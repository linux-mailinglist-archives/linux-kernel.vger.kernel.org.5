Return-Path: <linux-kernel+bounces-119652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B253388CB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13281C2DAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8ED84D3C;
	Tue, 26 Mar 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dustri.org header.i=@dustri.org header.b="iWujYG89"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD271CAA6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476435; cv=none; b=cFpnTqlBiseVE3JijZIjCJdvzWyitNWj2rDMlHOi3KGUqPdf71B8xLLSGX8Kn9+V1TFl9il3+ZyneU5gWh865T4BB1omNwHQ6z1vYYyoDj/SNR77JT8CrXLP3HHarnzbd/9pijc0vWdLIhmxfFX6uCFOP0wX3y90gDeee2tqWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476435; c=relaxed/simple;
	bh=7UNCW2kcIO62KpFiXK4tLLJmmCkVz+nRJw70ot9I/U0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=YON+JJs8/yC3g/XOyXv5Yg9FTIQHRC/lyi2qRQTK8q2tyurdKjObepBrwLCqT1h7B4zpja/ETk1xZdITk224RTgv0R0a2JpezoJvHIZ3KaVT+yOSgei7xQ3t1Fw5Z5hsf4KZD4Bb1V7FR41ROLy1WokQOVIK89smjOP/WYmpS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dustri.org; spf=pass smtp.mailfrom=dustri.org; dkim=pass (2048-bit key) header.d=dustri.org header.i=@dustri.org header.b=iWujYG89; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dustri.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dustri.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustri.org; s=key1;
	t=1711476429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mp+eVPd35ANrmUHHqEeuzw+1sE1zc47DWTxwutkbno0=;
	b=iWujYG89j5n/CEliW/PGvBdletusHp8aBgDJ2KTjukuq4UQ+Y0uQeNh+bdv+kFQ1XxsM9H
	clSjxlFbdxHY+INP3uakNno/FjCSQegYpEtA+YKB68PJLj2dG857lrER8klma0SdBhhTCs
	02nht8h3oMlpXP624GJIBHm39TvT+S2EN4QwDtsGvqtABPJQOhmis/lkBtQ3QGSygXQ+Kt
	kq1AwF+y+xpC/WU06ODZR0xk8RT/MS2Qvf0iMu6xamNjb2SNSPJnwUbdvsSbb31J40Seg2
	J78OCOJoXkoU+65uZ/lA1UtXp249T9TLJMZ/naAXGDQTBbjdDyj5XAiwlc43BQ==
Date: Tue, 26 Mar 2024 18:07:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: julien.voisin@dustri.org
Message-ID: <a88362316fb00494b78859625cabe0820ca26a15@dustri.org>
TLS-Required: No
Subject: Re: [PATCH v2 0/9] slab: Introduce dedicated bucket allocator
To: "Kees Cook" <keescook@chromium.org>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Julien Voisin" <jvoisin@google.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Christoph Lameter"
 <cl@linux.com>, "Pekka Enberg" <penberg@kernel.org>, "David Rientjes"
 <rientjes@google.com>, "Joonsoo Kim" <iamjoonsoo.kim@lge.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Hyeonggon Yoo"
 <42.hyeyoo@gmail.com>, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>, "Xiu
 Jianfeng" <xiujianfeng@huawei.com>, "Suren Baghdasaryan"
 <surenb@google.com>, "Kent Overstreet" <kent.overstreet@linux.dev>, "Jann
 Horn" <jannh@google.com>, "Matteo Rizzo" <matteorizzo@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org
In-Reply-To: <202403250958.DAFA70CC@keescook>
References: <20240305100933.it.923-kees@kernel.org>
 <5e1571de-2c5a-4be4-93f4-01582094ee96@suse.cz>
 <202403250958.DAFA70CC@keescook>
X-Migadu-Flow: FLOW_OUT

25 March 2024 at 19:24, "Kees Cook" <keescook@chromium.org> wrote:



>=20
>=20On Mon, Mar 25, 2024 at 10:03:23AM +0100, Vlastimil Babka wrote:
>=20
>=20>=20
>=20> On 3/5/24 11:10 AM, Kees Cook wrote:
> >=20
>=20>  Hi,
> >=20
>=20>=20=20
>=20>=20
>=20>  Repeating the commit logs for patch 4 here:
> >=20
>=20>=20=20
>=20>=20
>=20>  Dedicated caches are available For fixed size allocations via
> >=20
>=20>  kmem_cache_alloc(), but for dynamically sized allocations there is=
 only
> >=20
>=20>  the global kmalloc API's set of buckets available. This means it i=
sn't
> >=20
>=20>  possible to separate specific sets of dynamically sized allocation=
s into
> >=20
>=20>  a separate collection of caches.
> >=20
>=20>=20=20
>=20>=20
>=20>  This leads to a use-after-free exploitation weakness in the Linux
> >=20
>=20>  kernel since many heap memory spraying/grooming attacks depend on =
using
> >=20
>=20>  userspace-controllable dynamically sized allocations to collide wi=
th
> >=20
>=20>  fixed size allocations that end up in same cache.
> >=20
>=20>=20=20
>=20>=20
>=20>  While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defens=
e
> >=20
>=20>  against these kinds of "type confusion" attacks, including for fix=
ed
> >=20
>=20>  same-size heap objects, we can create a complementary deterministi=
c
> >=20
>=20>  defense for dynamically sized allocations.
> >=20
>=20>=20=20
>=20>=20
>=20>  In order to isolate user-controllable sized allocations from syste=
m
> >=20
>=20>  allocations, introduce kmem_buckets_create(), which behaves like
> >=20
>=20>  kmem_cache_create(). (The next patch will introduce kmem_buckets_a=
lloc(),
> >=20
>=20>  which behaves like kmem_cache_alloc().)
> >=20
>=20>=20=20
>=20>=20
>=20>  Allows for confining allocations to a dedicated set of sized cache=
s
> >=20
>=20>  (which have the same layout as the kmalloc caches).
> >=20
>=20>=20=20
>=20>=20
>=20>  This can also be used in the future once codetag allocation annota=
tions
> >=20
>=20>  exist to implement per-caller allocation cache isolation[0] even f=
or
> >=20
>=20>  dynamic allocations.
> >=20
>=20>=20=20
>=20>=20
>=20>  Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescoo=
k [0]
> >=20
>=20>=20=20
>=20>=20
>=20>  After the implemetation are 2 example patches of how this could be=
 used
> >=20
>=20>  for some repeat "offenders" that get used in exploits. There are m=
ore to
> >=20
>=20>  be isolated beyond just these. Repeating the commit log for patch =
8 here:
> >=20
>=20>=20=20
>=20>=20
>=20>  The msg subsystem is a common target for exploiting[1][2][3][4][5]=
[6]
> >=20
>=20>  use-after-free type confusion flaws in the kernel for both read an=
d
> >=20
>=20>  write primitives. Avoid having a user-controlled size cache share =
the
> >=20
>=20>  global kmalloc allocator by using a separate set of kmalloc bucket=
s.
> >=20
>=20>=20=20
>=20>=20
>=20>  Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux=
-kernel-exploit-development-1day-case-study/ [1]
> >=20
>=20>  Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-miti=
gation-ved/ [2]
> >=20
>=20>  Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvati=
on-writeup.html [3]
> >=20
>=20>  Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [=
4]
> >=20
>=20>  Link: https://google.github.io/security-research/pocs/linux/cve-20=
21-22555/writeup.html [5]
> >=20
>=20>  Link: https://zplin.me/papers/ELOISE.pdf [6]
> >=20
>=20>=20=20
>=20>=20
>=20>  Hi Kees,
> >=20
>=20>=20=20
>=20>=20
>=20>  after reading [1] I think the points should be addressed, mainly a=
bout the
> >=20
>=20>  feasibility of converting users manually.
> >=20
>=20
> Sure, I can do that.
>=20
>=20Adding Julien to this thread... Julien can you please respond to LKML
>=20
>=20patches in email? It's much easier to keep things in a single thread.=
 :)
>=20
>=20] This is playing wack-a-mole
>=20
>=20Kind of, but not really. These patches provide a mechanism for having
>=20
>=20dedicated dynamically-sized slab caches (to match kmem_cache_create()=
,
>=20
>=20which only works for fixed-size allocations). This is needed to expan=
d
>=20
>=20the codetag work into doing per-call-site allocations, as I detailed
>=20
>=20here[1].
>=20
>=20Also, adding uses manually isn't very difficult, as can be seen in th=
e
>=20
>=20examples I included. In fact, my examples between v1 and v2 collapsed
>=20
>=20from 3 to 2, because covering memdup_user() actually covered 2 known
>=20
>=20allocation paths (attrs and vma names), and given its usage pattern,
>=20
>=20will cover more in the future without changes.

It's not about difficulty, it's about scale. There are hundreds of intere=
sting structures: I'm worried that no one will take the time to add a sep=
arate bucket for each of them, chase their call-sites down, and monitor e=
very single newly added structures to check if they are "interesting" and=
 should benefit from their own bucket as well.

>=20
>=20] something like AUTOSLAB would be better
>=20
>=20Yes, that's the goal of [1]. This is a prerequisite for that, as
>=20
>=20mentioned in the cover letter.

This series looks unrelated to [1] to me: the former adds a mechanism to =
add buckets and expects developers to manually make use of them, while th=
e latter is about adding infrastructure to automate call-site-based segre=
gation.

> ] The slabs needs to be pinned
>=20
>=20Yes, and this is a general problem[2] with all kmalloc allocations, t=
hough.
>=20
>=20This isn't unique to to this patch series. SLAB_VIRTUAL solves it, an=
d
>=20
>=20is under development.

Then it would be nice to mention it in the serie, as an acknowledged limi=
tation.

> ] Lacks guard pages
>=20
>=20Yes, and again, this is a general problem with all kmalloc allocation=
s.
>=20
>=20Solving it, like SLAB_VIRTUAL, would be a complementary hardening
>=20
>=20improvement to the allocator generally.

Then it would also be nice to mention it, because currently it's unclear =
that those limitations are both known and will be properly addressed.

>=20
>=20] PAX_USERCOPY has been marking these sites since 2012
>=20
>=20Either it's whack-a-mole or it's not. :)=20

This=20annotation was added 12 years ago in PaX, and while it was state o=
f the art back then, I think that in 2024 we can do better than this.

> PAX_USERCOPY shows that it _is_ possible to mark all sites.

It shows that it's possible to annotate some sites (17 in grsecurity-3.1-=
4.9.9-201702122044.patch), and while it has a similar approach to your se=
ries, its annotations aren't conveying the same meaning.

> Regardless, like AUTOSLAB, PAX_USERCOPY isn't
>=20
>=20upstream, and its current implementation is an unpublished modificati=
on
>=20
>=20to a GPL project. I look forward to someone proposing it for inclusio=
n
>=20
>=20in Linux, but for now we can work with the patches where an effort _h=
as_
>=20
>=20been made to upstream them for the benefit of the entire ecosystem.
>=20
>=20] What about CONFIG_KMALLOC_SPLIT_VARSIZE
>=20
>=20This proposed improvement is hampered by not having dedicated
>=20
>=20_dynamically_ sized kmem caches, which this series provides. And with
>=20
>=20codetag-split allocations[1], the goals of CONFIG_KMALLOC_SPLIT_VARSI=
ZE
>=20
>=20are more fully realized, providing much more complete coverage.

CONFIG_KMALLOC_SPLIT_VARSIZE has been bypassed dozen of times in various =
ways as part of Google's kernelCTF.
Your series is, to my understanding, a weaker form of it. So I'm not supe=
r-convinced that it's the right approach to mitigate UAF.

Do you think it would be possible for Google to add this series to its ke=
rnelCTF, so gather empirical data on how feasible/easy it is to bypass it=
?

>=20
>=20] I have no idea how the community around the Linux kernel works with
>=20
>=20] their email-based workflows
>=20
>=20Step 1: reply to the proposal in email instead of (or perhaps in
>=20
>=20addition to) making blog posts. :)
>=20
>=20>=20
>=20> On a related technical note I
> >=20
>=20>  worry what will become of /proc/slabinfo when we convert non-trivi=
al amounts
> >=20
>=20>  of users.
> >=20
>=20
> It gets longer. :) And potentially makes the codetag /proc file
>=20
>=20redundant. All that said, there are very few APIs in the kernel where
>=20
>=20userspace can control both the size and contents of an allocation.
>=20
>=20>=20
>=20> Also would interested to hear Jann Horn et al.'s opinion, and wheth=
er the
> >=20
>=20>  SLAB_VIRTUAL effort will continue?
> >=20
>=20
> SLAB_VIRTUAL is needed to address the reclamation UAF gap, and is
>=20
>=20still being developed. I don't intend to let it fall off the radar.
>=20
>=20(Which is why I included Jann and Matteo in CC originally.)
>=20
>=20In the meantime, adding this series as-is kills two long-standing
>=20
>=20exploitation methodologies, and paves the way to providing very
>=20
>=20fine-grained caches using codetags (which I imagine would be entirely
>=20
>=20optional and trivial to control with a boot param).
>=20
>=20-Kees
>=20
>=20[1] https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook/
>=20
>=20[2] https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-k=
ernel-memory.html
>=20
>=20--=20
>=20
> Kees Cook
>

