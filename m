Return-Path: <linux-kernel+bounces-59688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B25B84FA71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D5EB2107F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872C7F48A;
	Fri,  9 Feb 2024 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6MFlSzZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0B7EF12
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497958; cv=none; b=jH+u830OmV9V+4A8rjO1xoCgW9lpTvSojKUBZPCPw9M3ZJExU7SF4lftW/7XZBnUPW9yi+ZKU1EC12lyhEzR3uwS19hxRVE78PvctI/Otgn6dwQ30dd1Y5hFAehpexmKAf+UtbAnbRG4nUzMtNm6YL3QmlKhVGZ2RrGZptNjJAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497958; c=relaxed/simple;
	bh=eCa7otyZga8ui0LT2a/f1iShzyZTgUiKXtc4vXi8UiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enZOuBbAkYiwk7uRlISK5/v1QbZJzSGfzfWJMUjizj7/Fclk9ZzpLBgYm2mYYQG8dqHn3upGO5YrHI7+zQsCRCN+42K3Y6r9V3lENZzVdOUPtXrqIPx+T5BD2BnWOPiVCzMU5lJo36Z/EK5nn2RODwoveKeLyZFex7YhNcf/dAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6MFlSzZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707497955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syjEctozhBfEeP9cGPctM232qlAEbknuGwIIN4ER+PU=;
	b=V6MFlSzZJBfhm/Lp9IljG/oGJhP+DSENQlTQBv4y05WiRstsOMg5QIFG9MTdHnupmWATOt
	otK3tHRebNmhgkzGsgCtOJ3nGdu1DAq+XiqLxuRR7jJVoMmGoysI4VqclV1Bhr9qA8Afy/
	1cQUYCZdOVZgvHPZyW+cl34dBP3y3kE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-c4G57TqTMmqR71MFAGNOnw-1; Fri, 09 Feb 2024 11:59:11 -0500
X-MC-Unique: c4G57TqTMmqR71MFAGNOnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5537885A58F;
	Fri,  9 Feb 2024 16:59:10 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.66])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE220C08EF7;
	Fri,  9 Feb 2024 16:59:05 +0000 (UTC)
Date: Fri, 9 Feb 2024 17:59:03 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
 <pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
 <anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v3 00/17] kexec: Allow preservation of ftrace buffers
Message-ID: <20240209175903.15dcc714@rotkaeppchen>
In-Reply-To: <3bfbe6b3-d293-483f-9f30-b7d49440be22@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
	<20240129173450.038e46b7@rotkaeppchen>
	<3bfbe6b3-d293-483f-9f30-b7d49440be22@amazon.com>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Alex,

On Fri, 2 Feb 2024 13:58:52 +0100
Alexander Graf <graf@amazon.com> wrote:

> Hi Philipp,
>=20
> On 29.01.24 17:34, Philipp Rudo wrote:
> > Hi Alex,
> >
> > adding linux-integrity as there are some synergies with IMA_KEXEC (in c=
ase we
> > get KHO to work).
> >
> > Fist of all I believe that having a generic framework to pass informati=
on from
> > one kernel to the other across kexec would be a good thing. But I'm afr=
aid that =20
>=20
>=20
> Thanks, I'm happy to hear that you agree with the basic motivation :).=20
> There are fundamentally 2 problems with passing data:
>=20
>  =C2=A0 * Passing structured data in a cross-architecture way
>  =C2=A0 * Passing memory
>=20
> KHO tackles both. It proposes a common FDT based format that allows us=20
> to pass per-subsystem properties. That way, a subsystem does not need to=
=20
> know whether it's running on ARM, x86, RISC-V or s390x. It just gains=20
> awareness for KHO and can pass data.
>=20
> On top of that, it proposes a standardized "mem" property (and some=20
> magic around that) which allows subsystems to pass memory.
>=20
>=20
> > you are ignoring some fundamental problems which makes it extremely har=
d, if
> > not impossible, to reliably transfer the kernel's state from one kernel=
 to the
> > other.
> >
> > One thing I don't understand is how reusing the scratch area is working=
 Sure
> > you pass it's location via the dt/boot_params but I don't see any code =
that
> > makes it a CMA region. So IIUC the scratch area won't be available for =
the 2nd
> > kernel. Which is probably for the better as IIUC the 2nd kernel gets lo=
aded and
> > runs inside that area and I don't believe the CMA design ever considere=
d that
> > the kernel image could be included in a CMA area. =20
>=20
>=20
> That one took me a lot to figure out sensibly (with recursion all the=20
> way down) while building KHO :). I hope I detailed it sensibly in the=20
> documentation - please let me know how to improve it in case it's=20
> unclear: https://lore.kernel.org/lkml/20240117144704.602-8-graf@amazon.co=
m/
>=20
> Let me explain inline using different words as well what happens:
>=20
> The first (and only the first) kernel that boots allocates a CMA region=20
> as "scratch region". It loads the new kernel into that region. It passes=
=20
> that region as "scratch region" to the next kernel. The next kernel now=20
> takes it and marks every page block that the scratch region spans as CMA:
>=20
> https://lore.kernel.org/lkml/20240117144704.602-3-graf@amazon.com/
>=20
> The CMA hint doesn't mean we create an actual CMA region. It mostly=20
> means that the kernel won't use this memory for any kernel allocations.=20
> Kernel allocations up to this point are allocations we don't need to=20
> pass on with KHO again. Kernel allocations past that point may be=20
> allocations that we want to pass, so we just never place them into the=20
> "scratch region" again.
>=20
> And because we now already have a scratch region from the previous=20
> kernel, we keep reusing that forever with any new KHO kexec.

Thanks for the explanation. I've missed the memblock_mark_scratch in
kho_populate. The code makes much more sense now :-)

Having that said, for complex series like this one I like to do the
review on a branch in my local git as that to avoid problems like that
(or at least make them less likely). But your patches didn't apply. Can
you tell me what your base is or make your git branch available. That
would be very helpful to me. Thanks!

> > Staying at reusing the scratch area. One thing that is broken for sure =
is that
> > you reuse the scratch area without ever checking the kho_scratch parame=
ter of
> > the 2nd kernel's command line. Remember, with kexec you are dealing wit=
h two
> > different kernels with two different command lines. Meaning you can onl=
y reuse
> > the scratch area if the requested size in the 2nd kernel is identical t=
o the
> > one of the 1st kernel. In all other cases you need to adjust the scratc=
h area's
> > size or reserve a new one. =20
>=20
>=20
> Hm. So you're saying a user may want to change the size of the scratch=20
> area with a KHO kexec. That's insanely risky because you (as rightfully=20
> pointed out below) may have significant fragmentation at that point. And=
=20
> we will only know when we're in the new kernel so it's too late to=20
> abort. IMHO it's better to just declare the scratch region as immutable=20
> during KHO to avoid that pitfall.

Yes, a user can set any command line with kexec. My expectation as a
user is that the kernel respects whatever I set on the command line and
doesn't think it knows better and simply ignores what I tell it to do.
So even when you set the scratch area immutable during boot you have to
make sure that in the end kernel respects what the user has set on the
2nd kernel's command line.

> > This directly leads to the next problem. In kho_reserve_previous_mem yo=
u are
> > reusing the different memory regions wherever the 1st kernel allocated =
them.
> > But that also means you are handing over the 1st kernel's memory
> > fragmentation to the 2nd kernel and you do that extremely early during =
boot.
> > Which means that users who need to allocate large continuous physical m=
emory,
> > like the scratch area or the crashkernel memory, will have increasing c=
hance to
> > not find a suitable area. Which IMHO is unacceptable. =20
>=20
>=20
> Correct :). It basically means you want to pass large allocations from=20
> the 1st kernel that you want to preserve on to the next. So if the 1st=20
> kernel allocated a large crash area, it's safest to pass that allocation=
=20
> using KHO to ensure the next kernel also has the region fully reserved.=20
> Otherwise the next kernel may accidentally place data into the=20
> previously reserved crash region (which would be contiguously free at=20
> early init of the 2nd kernel) and fragment it again.

I don't think that this is an option. For one your suggestion means that
every "large allocation" (whatever that means) needs to be tracked
manually for it to work together with KHO. In addition there is still
the problem that the 2nd kernel may need a larger allocation than the
1st one. Be it because it's a command line parameter, e.g. kho_scratch
or crashkernel, or just a new feature that requires additional memory
the 2nd kernel has. IMO it's inevitable that KHO finds a way to
remove/reduce memory fragmentation.

> > Finally, and that's the big elephant in the room, is your lax handling =
of the
> > unstable kernel internal ABI. Remember, you are dealing with two differ=
ent
> > kernels, that also means two different source levels and two different =
configs.
> > So only because both the 1st and 2nd kernel have a e.g. struct buffer_p=
age
> > doesn't means that they have the same struct buffer_page. But that's wh=
at your
> > code implicitly assumes. For KHO ever to make it upstream you need to m=
ake sure
> > that both kernels are "speaking the same language". =20
>=20
>=20
> Wow, I hope it didn't come across as that! The whole point of using FDT=20
> and compatible strings in KHO is to solve exactly that problem. Any time=
=20
> a passed over data structure changes incompatibly, you would need to=20
> modify the compatible string of the subsystem that owns the now=20
> incompatible data.
>=20
> So in the example of struct buffer_page, it means that if anyone changes=
=20
> the few bits we care about in struct buffer_page, we need to ensure that=
=20
> the new kernel emits "ftrace,cpu-v2" compatible strings. We can at that=20
> point choose whether we want to implement compat handling for=20
> "ftrace,cpu-v1" style struct buffer_pages or only support same version=20
> ingestion.

Well, it came across like that because there was absolutely no
explanation on when those versions need to be bumped up so far.

> The one thing that we could improve on here today IMHO is to have=20
> compile time errors if any part of struct buffer_page changes=20
> semantically: So we'd create a few defines for the bits we want in=20
> "ftrace,cpu-v1" as well as size of struct buffer_page and then compare=20
> them to what the struct offsets are at compile time to ensure they stay=20
> identical.

How do you imagine those macros to look like? How do they work with
structs that change their layout depending on the config?

Personally, I highly doubt that any system that manages these different
versions manually will work reliably. It might be possible for
something as simple as struct buffer_page but once it gets more
complicated, e.g. by depending on the kernel config or simply having
more dependencies to common data structures, it will be a constant
source of pain.
Just assume, although extremely unlikely, that struct list_head is
changed. Most likely the person who makes the change won't be from the
ftrace team and thus won't know that he/she/it needs to bump the
version. Even the compile time errors will only help if
CONFIG_FTRACE_KHO is enabled which most like won't be the case.
Ultimately this means that KHO will break silently until someone tries
to kexec in the new kernel with KHO enabled. But even then there will
only be a cryptic error message (if any) as you have basically
introduced a memory corruption to the 2nd kernel. The more complex the
structs become and the deeper the dependency list goes the more likely
it becomes that such a breaking change is made.

The way I see it there is no way around generating the version based on
the actual memory layout for this particular build.

> Please let me know how I can clarify that more in the documentation. It=20
> really is the absolute core of KHO.
>=20
>=20
> > Personally I see two possible solutions:
> >
> > 1) You introduce a stable intermediate format for every subsystem simil=
ar to
> > what IMA_KEXEC does. This should work for simple types like struct buff=
er_page
> > but for complex ones like struct vfio_device that's basically impossibl=
e. =20
>=20
>=20
> I don't see why. The only reason KHO passes struct buffer_page as memory=
=20
> is because we want to be able to produce traces even after KHO=20
> serialization is done. For vfio_device, I think it's perfectly=20
> reasonable to serialize any data we need to preserve directly into FDT=20
> properties.
>=20
>=20
>=20
> > 2) You also hand over the ABI version for every given type (basically j=
ust a
> > hash over all fields including all the dependencies). So the 2nd kernel=
 can
> > verify that the data handed over is in a format it can handle and if no=
t bail
> > out with a descriptive error message rather than reading garbage. Plus =
side is
> > that once such a system is in place you can reuse it to automatically r=
esolve
> > all dependencies so you no longer need to manually store the buffer_pag=
e and
> > its buffer_data_page separately.
> > Down side is that traversing the debuginfo (including the ones from mod=
ules) is
> > not a simple task and I expect that such a system will be way more comp=
lex than
> > the rest of KHO. In addition there are some cases that the versioning w=
on't be
> > able to capture. For example if a type contains a "void *"-field. Then =
although
> > the definition of the type is identical in both kernels the field can b=
e cast
> > to different types when used. An other problem will be function pointer=
s which
> > you first need to resolve in the 1st kernel and then map to the identic=
al
> > function in the 2nd kernel. This will become particularly "fun" when the
> > function is part of a module that isn't loaded at the time when you try=
 to
> > recreate the kernel's state. =20
>=20
>=20
> The whole point of KHO is to leave it to the subsystem which path they=20
> want to take. The subsystem can either pass binary data and validate as=20
> part of FDT properties (like compatible strings). That data can be=20
> identical to today's in-kernel data structures (usually a bad idea) or=20
> can be a new intermediate data format. But the subsystem can also choose=
=20
> to fully serialize into FDT properties and not pass any memory at all=20
> for state that would be in structs. Or something in between.

That's totally fine. My point is that there are simply too many ways to
fuck it up and break the 2nd kernel. That's why I don't believe that we
can rely on the subsystems to "do it right" and "remember to bump the
version". In other words, KHO needs to provide a reliable, automatic
mechanism with wich the 2nd kernel can decide if it can handle the
passed data or not.

> > So to summarize, while it would be nice to have a generic framework lik=
e KHO to
> > pass data from one kernel to the other via kexec there are good reasons=
 why it
> > doesn't exist, yet. =20
>=20
>=20
> I hope my explanations above clarify things a bit. Let me know if you're=
=20
> at FOSDEM, happy to talk about the internals there as well :)

Sorry, I couldn't make it to FOSDEM but I plan to be at LPC later this
year. In fact I had your talk on my list last year. Unfortunately it was
parallel to the kernel debugger mc...

Thanks
Philipp

> Alex
>=20
>=20
>=20
>=20
>=20
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>=20
>=20
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


