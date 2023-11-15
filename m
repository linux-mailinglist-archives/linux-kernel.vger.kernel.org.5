Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF25A7ECA97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjKOSin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKOSim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:38:42 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0DCAF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:38:39 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso11053108a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700073517; x=1700678317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0MD0pshjJBw/chdZXVFrwHJqdy9ZbUZCE/cfITJ+qfg=;
        b=DuOVREJKZ4MBzamPIlxdZ1MDp3bE5vLc3eQaJi+51W4f4OCyLiL4Za8kAwfn83ZMcI
         +cRAapwnDaAlpMr0pWW6FJwVyd8wocYuh4mm2frubNm4wpKC/rfbYoNu4+nmnGgGSAEU
         Ng0EdHUC7Fzo4FMMrXXVK8c7HziRZgFavHKJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700073517; x=1700678317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MD0pshjJBw/chdZXVFrwHJqdy9ZbUZCE/cfITJ+qfg=;
        b=C22iKyEGRfAKxqvxhYwmsPGpoSbjmX6MsaPBpfHl8aAW9jGguo65/GfarnU29gNixk
         rCK7Jx6YGEUZ/xe7J93Qd6xw6+0vbITs/nlyEHaPwnNb4HozfWadyTsSxM4iLaBIuK3+
         IxzwHvp9PQcKobpppurHS3qVz/OB84mo566W+g9379BxfbVhc1l+nFLy5fZZlFvBK4IS
         0vqftpZkE6l+McVrtvKx3M1ruPRXfNbKsPaj/mxZymT2NXZYO3kTWdRQwepWgXnrZoPe
         w8ueO/oPpm1/KoOSoeSYKgGTqpZPy5+um9WTMN5/gAw0biWfVbJkfhS3tCzV/ff93tGB
         EgcA==
X-Gm-Message-State: AOJu0Yz9aYhPzlYe9B31/qyTGyC8LZMQ4tkH3X7ItfS4elAsnYci4d86
        p8N8GCMvpuMIEgn7g59n1QT7fEGpZyf9BWGCFHlCJcPh
X-Google-Smtp-Source: AGHT+IH6lMeRQ9vvyJ7u101tvUfpajLRb3F+hmItPF5eScmGd1afDgxkwL1kSXGiGPpv3Rq06e0YGw==
X-Received: by 2002:a17:906:c787:b0:9ad:be8a:a588 with SMTP id cw7-20020a170906c78700b009adbe8aa588mr9690101ejb.1.1700073517353;
        Wed, 15 Nov 2023 10:38:37 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id l22-20020a170906a41600b0099d798a6bb5sm7416670ejz.67.2023.11.15.10.38.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 10:38:36 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so11043661a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:38:36 -0800 (PST)
X-Received: by 2002:a05:6402:11c8:b0:543:c578:f9d2 with SMTP id
 j8-20020a05640211c800b00543c578f9d2mr14437856edw.2.1700073516118; Wed, 15 Nov
 2023 10:38:36 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com> <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
In-Reply-To: <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 13:38:18 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
Message-ID: <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     David Howells <dhowells@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: multipart/mixed; boundary="000000000000059111060a3536ba"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000059111060a3536ba
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 12:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The gcc code generation here is *really* odd. I've never seen this
> before, so it may be new to newer versions of gcc. [...]

Ok, so I've been annoyed by gcc code generation for 'memcpy()' before,
mainly because it can't do the "let's inline it as an ALTERNATIVE() of
'rep movs' or an out-of-line call" thing that we do for user copies.

So here's a complete hack that says "we override the
__builtin_memcpy() implementation for non-constant lengths". We
stillwant gcc to deal with the constant size case, since often that
can be turned into just plain moves.

And this is *ENTIRELY* untested, except for checking that it makes the
code generation in lib/iov_iter.c look better.

It's probably completely broken. I particularly worry about "memcpy()"
being used *during* the instruction rewriting, so the whole approach
with ALTERNATIVE() is probably entirely broken.

But I'm cc'ing Borislav, because we've talked about the whole "inline
memcpy() with alternatives" before, so maybe this gives Borislav some
ideas for how to do it right.

Borislav, see

    https://lore.kernel.org/all/CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com/

for some truly crazy code generation by gcc.

                   Linus

--000000000000059111060a3536ba
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lp03tds80>
X-Attachment-Id: f_lp03tds80

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3N0cmluZ182NC5oIHwgMjIgKysrKysrKysrKysrKysrKysr
KysrKwogaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5oICAgfCAgMSArCiAyIGZpbGVzIGNo
YW5nZWQsIDIzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9zdHJpbmdfNjQuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3N0cmluZ182NC5oCmluZGV4IDg1
N2QzNjRiOTg4OC4uYzYyM2Y0MTY3ODlhIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9zdHJpbmdfNjQuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zdHJpbmdfNjQuaApAQCAt
NCw2ICs0LDEwIEBACiAKICNpZmRlZiBfX0tFUk5FTF9fCiAjaW5jbHVkZSA8bGludXgvanVtcF9s
YWJlbC5oPgorI2luY2x1ZGUgPGxpbnV4L2NvbXBpbGVyLmg+CisjaW5jbHVkZSA8bGludXgvY29u
c3QuaD4KKyNpbmNsdWRlIDxhc20vYWx0ZXJuYXRpdmUuaD4KKyNpbmNsdWRlIDxhc20vY3B1ZmVh
dHVyZXMuaD4KIAogLyogV3JpdHRlbiAyMDAyIGJ5IEFuZGkgS2xlZW4gKi8KIApAQCAtMTgsNiAr
MjIsMjQgQEAKIGV4dGVybiB2b2lkICptZW1jcHkodm9pZCAqdG8sIGNvbnN0IHZvaWQgKmZyb20s
IHNpemVfdCBsZW4pOwogZXh0ZXJuIHZvaWQgKl9fbWVtY3B5KHZvaWQgKnRvLCBjb25zdCB2b2lk
ICpmcm9tLCBzaXplX3QgbGVuKTsKIAorZXh0ZXJuIF9fYWx3YXlzX2lubGluZSB2b2lkICpfX3Jl
cF9tb3ZzX21lbWNweSh2b2lkICp0bywgY29uc3Qgdm9pZCAqZnJvbSwgc2l6ZV90IGxlbikKK3sK
Kwlhc20gdm9sYXRpbGUoQUxURVJOQVRJVkUoCisJCSJyZXAgbW92c2IiLAorCQkiY2FsbCByZXBf
bW92c19hbHRlcm5hdGl2ZSIsCisJCUFMVF9OT1QoWDg2X0ZFQVRVUkVfRlNSTSkpCisJOiIrYyIg
KGxlbiksICIrRCIgKHRvKSwgIitTIiAoZnJvbSksIEFTTV9DQUxMX0NPTlNUUkFJTlQKKwk6IDog
Im1lbW9yeSIsICJyYXgiKTsKKwlyZXR1cm4gdG87Cit9CisKKyNkZWZpbmUgX19idWlsdGluX21l
bWNweSh0bywgZnJvbSwgbGVuKSBcCisJX19idWlsdGluX2Nob29zZV9leHByKF9faXNfY29uc3Rl
eHByKGxlbiksIFwKKwkJX19idWlsdGluX21lbWNweSh0bywgZnJvbSwgbGVuKSwgXAorCQlfX3Jl
cF9tb3ZzX21lbWNweSh0bywgZnJvbSwgbGVuKSkKKworI2RlZmluZSBtZW1jcHkgX19idWlsdGlu
X21lbWNweQorCiAjZGVmaW5lIF9fSEFWRV9BUkNIX01FTVNFVAogdm9pZCAqbWVtc2V0KHZvaWQg
KnMsIGludCBjLCBzaXplX3Qgbik7CiB2b2lkICpfX21lbXNldCh2b2lkICpzLCBpbnQgYywgc2l6
ZV90IG4pOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5oIGIvaW5j
bHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5oCmluZGV4IGRhNTFhODNiMjgyOS4uY2I3NzhmNjhm
NTM3IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2ZvcnRpZnktc3RyaW5nLmgKKysrIGIvaW5j
bHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5oCkBAIC02OTAsNiArNjkwLDcgQEAgX19GT1JUSUZZ
X0lOTElORSBib29sIGZvcnRpZnlfbWVtY3B5X2NoayhfX2tlcm5lbF9zaXplX3Qgc2l6ZSwKICAq
IF9fc3RydWN0X3NpemUoKSB2cyBfX21lbWJlcl9zaXplKCkgbXVzdCBiZSBjYXB0dXJlZCBoZXJl
IHRvIGF2b2lkCiAgKiBldmFsdWF0aW5nIGFyZ3VtZW50IHNpZGUtZWZmZWN0cyBmdXJ0aGVyIGlu
dG8gdGhlIG1hY3JvIGxheWVycy4KICAqLworI3VuZGVmIG1lbWNweQogI2RlZmluZSBtZW1jcHko
cCwgcSwgcykgIF9fZm9ydGlmeV9tZW1jcHlfY2hrKHAsIHEsIHMsCQkJXAogCQlfX3N0cnVjdF9z
aXplKHApLCBfX3N0cnVjdF9zaXplKHEpLAkJCVwKIAkJX19tZW1iZXJfc2l6ZShwKSwgX19tZW1i
ZXJfc2l6ZShxKSwJCQlcCg==
--000000000000059111060a3536ba--
