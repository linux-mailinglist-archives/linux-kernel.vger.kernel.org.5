Return-Path: <linux-kernel+bounces-13591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC33F82087B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 21:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90765B21DA6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 20:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8910BC2FD;
	Sat, 30 Dec 2023 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AzFvYA1D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53DC148
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso8746756e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 12:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703968891; x=1704573691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oqev+qKsNZg84TyjAN9i8DWy8xYTUxkGZNijcPktMwo=;
        b=AzFvYA1DirZJfR/o97N8OAIyDP6oGeqv4R28ulMzGTuBA9yDXaC+PcJl2W6CG/J51U
         4XtmlGs6gLbby6DsxAlAK56VjFc9IIxiP/M7GloH+99TnvaRk6ObBBg3TVel89jV76n8
         oh0hzBtUBqNBqL5JrwPT4e4U6XPrh9CK5/rIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703968891; x=1704573691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqev+qKsNZg84TyjAN9i8DWy8xYTUxkGZNijcPktMwo=;
        b=Ua7yiAYzACbOxWegHwEsBBQqEun7l/QjKKZbNs9XfmoybepMOB0KzMTpbMkROGQmbG
         Dhz9xyYlhNtAdv2wqlGfdC35QzvIEDj6x+Auk3/sPe0dk+CuXuFORtR9dv+S10Zp9dsb
         4agB2aREznb3/isTPt8B2MU7/bvKtcLHMD6BKfOkrMN0XpNNmvACCkYNWBXTYM+PM11O
         xrJPiaXLSw3r6ZrkcnGQqNt4J7Fv6ZnhXcBraBP3QFTU8mUvM83aC++8qsfb5dFdkwV/
         uD+lc5crGQUrvaVqY2+a+w35kvg/c8frSh88ICw+e6dTNJ9frbIg9v6x/eSiTBdM0PUe
         dqVQ==
X-Gm-Message-State: AOJu0Yyweawl53yabN5wAbV0/O+9Tc991EasYYKtU3bpQ+fHCF7nGN7J
	n475HnAifuuBqrWmj8axv93A/kFC/YDPY9e9bAYrLs8iyQ5qCg==
X-Google-Smtp-Source: AGHT+IGVcLBrnRVzXdbq0RON5GUnJ5+b5Di8ZXe6s8I2ECcK8i3QAIRWzW+qIV9mh9liolEuEbRmeg==
X-Received: by 2002:a05:6512:3885:b0:50e:7709:9fc2 with SMTP id n5-20020a056512388500b0050e77099fc2mr3690644lft.78.1703968891084;
        Sat, 30 Dec 2023 12:41:31 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id vz11-20020a17090704cb00b00a26afd1197dsm8562679ejb.54.2023.12.30.12.41.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 12:41:30 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a23350cd51cso872925366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 12:41:30 -0800 (PST)
X-Received: by 2002:a17:906:208a:b0:a26:f083:d89a with SMTP id
 10-20020a170906208a00b00a26f083d89amr3518174ejq.75.1703968889891; Sat, 30 Dec
 2023 12:41:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com> <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
In-Reply-To: <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Dec 2023 12:41:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjbWTbRKDP=Yb9VWBGjSBEGB3dJ0=--+7-4oA2n1=1FKw@mail.gmail.com>
Message-ID: <CAHk-=wjbWTbRKDP=Yb9VWBGjSBEGB3dJ0=--+7-4oA2n1=1FKw@mail.gmail.com>
Subject: Re: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data accesses.
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com" <longman@redhat.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"xinhui.pan@linux.vnet.ibm.com" <xinhui.pan@linux.vnet.ibm.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	Zeng Heng <zengheng4@huawei.com>
Content-Type: multipart/mixed; boundary="000000000000641af2060dc02c7b"

--000000000000641af2060dc02c7b
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Dec 2023 at 12:57, David Laight <David.Laight@aculab.com> wrote:
>
> this_cpu_ptr() is rather more expensive than raw_cpu_read() since
> the latter can use an 'offset from register' (%gs for x86-84).
>
> Add a 'self' field to 'struct optimistic_spin_node' that can be
> read with raw_cpu_read(), initialise on first call.

No, this is horrible.

The problem isn't the "this_cpu_ptr()", it's the rest of the code.

>  bool osq_lock(struct optimistic_spin_queue *lock)
>  {
> -       struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> +       struct optimistic_spin_node *node = raw_cpu_read(osq_node.self);

No. Both of these are crap.

>         struct optimistic_spin_node *prev, *next;
>         int old;
>
> -       if (unlikely(node->cpu == OSQ_UNLOCKED_VAL))
> -               node->cpu = encode_cpu(smp_processor_id());
> +       if (unlikely(!node)) {
> +               int cpu = encode_cpu(smp_processor_id());
> +               node = decode_cpu(cpu);
> +               node->self = node;
> +               node->cpu = cpu;
> +       }

The proper fix here is to not do that silly

        node = this_cpu_ptr(&osq_node);
        ..
        node->next = NULL;

dance at all, but to simply do

        this_cpu_write(osq_node.next, NULL);

in the first place. That makes the whole thing just a single store off
the segment descriptor.

Yes, you'll eventually end up doing that

        node = this_cpu_ptr(&osq_node);

thing because it then wants to use that raw pointer to do

        WRITE_ONCE(prev->next, node);

but that's a separate issue and still does not make it worth it to
create a pointless self-pointer.

Btw, if you *really* want to solve that separate issue, then make the
optimistic_spin_node struct not contain the pointers at all, but the
CPU numbers, and then turn those numbers into the pointers the exact
same way it does for the "lock->tail" thing, ie doing that whole

        prev = decode_cpu(old);

dance. That *may* then result in avoiding turning them into pointers
at all in some cases.

Also, I think that you might want to look into making OSQ_UNLOCKED_VAL
be -1 instead, and add something like

  #define IS_OSQ_UNLOCKED(x) ((int)(x)<0)

and that would then avoid the +1 / -1 games in encoding/decoding the
CPU numbers. It causes silly code generated like this:

        subl    $1, %eax        #, cpu_nr
...
        cltq
        addq    __per_cpu_offset(,%rax,8), %rcx

which seems honestly stupid. The cltq is there for sign-extension,
which is because all these things are "int", and the "subl" will
zero-extend to 64-bit, not sign-extend.

At that point, I think gcc might be able to just generate

        addq    __per_cpu_offset-8(,%rax,8), %rcx

but honestly, I think it would be nicer to just have decode_cpu() do

        unsigned int cpu_nr = encoded_cpu_val;

        return per_cpu_ptr(&osq_node, cpu_nr);

and not have the -1/+1 at all.

Hmm?

UNTESTED patch to just do the "this_cpu_write()" parts attached.
Again, note how we do end up doing that this_cpu_ptr conversion later
anyway, but at least it's off the critical path.

                 Linus

--000000000000641af2060dc02c7b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lqsj1wd50>
X-Attachment-Id: f_lqsj1wd50

IGtlcm5lbC9sb2NraW5nL29zcV9sb2NrLmMgfCAxMiArKysrKysrLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVs
L2xvY2tpbmcvb3NxX2xvY2suYyBiL2tlcm5lbC9sb2NraW5nL29zcV9sb2NrLmMKaW5kZXggNzVh
NmY2MTMzODY2Li5jM2ExNjZiNzkwMGMgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9sb2NraW5nL29zcV9s
b2NrLmMKKysrIGIva2VybmVsL2xvY2tpbmcvb3NxX2xvY2suYwpAQCAtOTIsMTQgKzkyLDE0IEBA
IG9zcV93YWl0X25leHQoc3RydWN0IG9wdGltaXN0aWNfc3Bpbl9xdWV1ZSAqbG9jaywKIAogYm9v
bCBvc3FfbG9jayhzdHJ1Y3Qgb3B0aW1pc3RpY19zcGluX3F1ZXVlICpsb2NrKQogewotCXN0cnVj
dCBvcHRpbWlzdGljX3NwaW5fbm9kZSAqbm9kZSA9IHRoaXNfY3B1X3B0cigmb3NxX25vZGUpOwor
CXN0cnVjdCBvcHRpbWlzdGljX3NwaW5fbm9kZSAqbm9kZTsKIAlzdHJ1Y3Qgb3B0aW1pc3RpY19z
cGluX25vZGUgKnByZXYsICpuZXh0OwogCWludCBjdXJyID0gZW5jb2RlX2NwdShzbXBfcHJvY2Vz
c29yX2lkKCkpOwogCWludCBvbGQ7CiAKLQlub2RlLT5sb2NrZWQgPSAwOwotCW5vZGUtPm5leHQg
PSBOVUxMOwotCW5vZGUtPmNwdSA9IGN1cnI7CisJdGhpc19jcHVfd3JpdGUob3NxX25vZGUubmV4
dCwgTlVMTCk7CisJdGhpc19jcHVfd3JpdGUob3NxX25vZGUubG9ja2VkLCAwKTsKKwl0aGlzX2Nw
dV93cml0ZShvc3Ffbm9kZS5jcHUsIGN1cnIpOwogCiAJLyoKIAkgKiBXZSBuZWVkIGJvdGggQUNR
VUlSRSAocGFpcnMgd2l0aCBjb3JyZXNwb25kaW5nIFJFTEVBU0UgaW4KQEAgLTExMiw3ICsxMTIs
OSBAQCBib29sIG9zcV9sb2NrKHN0cnVjdCBvcHRpbWlzdGljX3NwaW5fcXVldWUgKmxvY2spCiAJ
CXJldHVybiB0cnVlOwogCiAJcHJldiA9IGRlY29kZV9jcHUob2xkKTsKLQlub2RlLT5wcmV2ID0g
cHJldjsKKwl0aGlzX2NwdV93cml0ZShvc3Ffbm9kZS5wcmV2LCBwcmV2KTsKKworCW5vZGUgPSB0
aGlzX2NwdV9wdHIoJm9zcV9ub2RlKTsKIAogCS8qCiAJICogb3NxX2xvY2soKQkJCXVucXVldWUK
--000000000000641af2060dc02c7b--

