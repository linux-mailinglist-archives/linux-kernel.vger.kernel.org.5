Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585267F9549
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 21:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjKZUYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 15:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZUYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 15:24:11 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B6111
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 12:24:17 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a04196fc957so513927366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 12:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701030256; x=1701635056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9m0VkYBMPQAAqcfnyKJyHPhdZmsbJX1nKe+Mjna/jI=;
        b=EGH0rRnh12YtBQDh+ogT7oqNTqVSizbHnbv0xwiqhVAgHB1FE1THLh6hozAAZ/3vnA
         BbDxzjw9i4tTh3j0elQ16Ijx5maS1lxO0nj0n0hibNdWhnbtk9TTvsW2rxwVau7+fnKV
         oAdhWn4B2Lrv+8Eftxxit2Jat9/jbB4e2ShyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701030256; x=1701635056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9m0VkYBMPQAAqcfnyKJyHPhdZmsbJX1nKe+Mjna/jI=;
        b=FFTogDa03oyDA6SRClptXgI0+t84NA47g/b2fklfa7KSgJ3DeiAirvrL36aLfF3FCt
         4GEYiLZXTdugbw5ssABOoRwadywKTdGmvaCRdkYjkF3DbSX/gfUiG4xZ1qNmZvz7HROh
         8b8NlRs2Vis5ZVqEpB7iWoSEAK2YbeN6cJbpqP+JF0lDo5BzX61mG1d5cipBl951mScj
         cI7SXoaZmqTZ9oSj+0j2AV8Bl1nPMSApMMdJ4z619z05z9Li4bSVQttpNLp7xFf+LNlr
         gwJMiAnR4C8Keq+1+Djwq0nXg4AIs6D0wDMa1zXa0m1Ys4WasTt3MaH0MXKID4Rwloi7
         92dQ==
X-Gm-Message-State: AOJu0YxqIea6LtccfStG8OAlHEWaxhXXXBr5CXYlwD6OBqFWhFLfBHrh
        OSZCPh/0y6278XVOPwiv+fopH5AfpofKfSCtox8eYRkq
X-Google-Smtp-Source: AGHT+IFHKK1FNXMcwJOcB6vLprf1qfRoO9KzUj9ztmB94Ivzzv8t8TIAUjBhvWRjda6UNYiDoBT3EA==
X-Received: by 2002:a17:906:5345:b0:a0c:5dc9:5238 with SMTP id j5-20020a170906534500b00a0c5dc95238mr2505423ejo.38.1701030255742;
        Sun, 26 Nov 2023 12:24:15 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id s20-20020a1709066c9400b009fd585a2155sm4841177ejr.0.2023.11.26.12.24.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 12:24:14 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a04196fc957so513924666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 12:24:14 -0800 (PST)
X-Received: by 2002:a17:906:28e:b0:a0a:f934:6075 with SMTP id
 14-20020a170906028e00b00a0af9346075mr3560404ejf.39.1701030253926; Sun, 26 Nov
 2023 12:24:13 -0800 (PST)
MIME-Version: 1.0
References: <202311201406.2022ca3f-oliver.sang@intel.com>
In-Reply-To: <202311201406.2022ca3f-oliver.sang@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Nov 2023 12:23:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
Message-ID: <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
Subject: Re: [linus:master] [file] 0ede61d858: will-it-scale.per_thread_ops
 -2.9% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Christian Brauner <brauner@kernel.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        bpf@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com,
        fengwei.yin@intel.com
Content-Type: multipart/mixed; boundary="00000000000009cc68060b13f8a2"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000009cc68060b13f8a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Nov 2023 at 23:11, kernel test robot <oliver.sang@intel.com> wro=
te:
>
> kernel test robot noticed a -2.9% regression of will-it-scale.per_thread_=
ops on:
>
> commit: 0ede61d8589cc2d93aa78230d74ac58b5b8d0244 ("file: convert to SLAB_=
TYPESAFE_BY_RCU")

Ok, so __fget_light() is one of our more performance-critical things,
and that commit ends up making it call a rather more expensive version
in __get_file_rcu(), so we have:

>      30.90 =C4=85  4%     -20.6       10.35 =C4=85  2%  perf-profile.self=
.cycles-pp.__fget_light
>       0.00           +26.5       26.48        perf-profile.self.cycles-pp=
.__get_file_rcu

and that "20% decrease balanced by 26% increase elsewhere" then
directly causes the ~3% regression.

I took a look at the code generation, and honestly, I think we're
better off just making __fget_files_rcu() have special logic for this
all, and not use __get_file_rcu().

The 'fd' case really is special because we need to do that
non-speculative pointer access.

Because it turns out that we already have to use array_index_nospec()
to safely generate that pointer to the fd entry, and once you have to
do that "use non-speculative accesses to generate a safe pointer", you
might as well just go whole hog.

So this takes a different approach, and uses the
array_index_mask_nospec() thing that we have exactly to generate that
non-speculative mask for these things:

        /* Mask is a 0 for invalid fd's, ~0 for valid ones */
        mask =3D array_index_mask_nospec(fd, fdt->max_fds);

and then it does something you can consider either horribly clever, or
horribly ugly (this first part is basically just
array_index_nospec()):

        /* fdentry points to the 'fd' offset, or fdt->fd[0] */
        fdentry =3D fdt->fd + (fd&mask);

and then we can just *unconditionally* do the load - but since we
might be loading fd[0] for an invalid case, we need to mask the result
too:

        /* Do the load, then mask any invalid result */
        file =3D rcu_dereference_raw(*fdentry);
        file =3D (void *)(mask & (unsigned long)file);

but now we have done everything without any conditionals, and the only
conditional is now "did we load NULL" - which includes that "we masked
the bad value".

Then we just do that atomic_long_inc_not_zero() on the file, and
re-check the pointer chain we used.

I made files_lookup_fd_raw() do the same thing.

The end result is much nicer code generation at least from my quick
check. And I assume the regression will be gone, and hopefully even
turned into an improvement since this is so hot.

Comments? I also looked at that odd OPTIMIZER_HIDE_VAR() that
__get_file_rcu() does, and I don't get it. Both things come from
volatile accesses, I don't see the point of those games, but I also
didn't care, since it's no longer in a critical code path.

Christian?

NOTE! This patch is not well tested. I verified an earlier version of
this, but have been playing with it since, so caveat emptor.

IOW, I might have messed up some "trivial cleanup" when prepping for
sending it out...

              Linus

--00000000000009cc68060b13f8a2
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lpfx3pqa0>
X-Attachment-Id: f_lpfx3pqa0

IGZzL2ZpbGUuYyAgICAgICAgICAgICAgIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tCiBpbmNsdWRlL2xpbnV4L2ZkdGFibGUuaCB8IDE1ICsrKysr
KysrKystLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9mcy9maWxlLmMgYi9mcy9maWxlLmMKaW5kZXggNWZiMGIxNDZl
NzllLi5jNzRhNmU4Njg3ZDkgMTAwNjQ0Ci0tLSBhL2ZzL2ZpbGUuYworKysgYi9mcy9maWxlLmMK
QEAgLTk1OSwzMSArOTU5LDQyIEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGZpbGUgKl9fZmdldF9m
aWxlc19yY3Uoc3RydWN0IGZpbGVzX3N0cnVjdCAqZmlsZXMsCiAJCXN0cnVjdCBmaWxlICpmaWxl
OwogCQlzdHJ1Y3QgZmR0YWJsZSAqZmR0ID0gcmN1X2RlcmVmZXJlbmNlX3JhdyhmaWxlcy0+ZmR0
KTsKIAkJc3RydWN0IGZpbGUgX19yY3UgKipmZGVudHJ5OworCQl1bnNpZ25lZCBsb25nIG1hc2s7
CiAKLQkJaWYgKHVubGlrZWx5KGZkID49IGZkdC0+bWF4X2ZkcykpCisJCS8qIE1hc2sgaXMgYSAw
IGZvciBpbnZhbGlkIGZkJ3MsIH4wIGZvciB2YWxpZCBvbmVzICovCisJCW1hc2sgPSBhcnJheV9p
bmRleF9tYXNrX25vc3BlYyhmZCwgZmR0LT5tYXhfZmRzKTsKKworCQkvKiBmZGVudHJ5IHBvaW50
cyB0byB0aGUgJ2ZkJyBvZmZzZXQsIG9yIGZkdC0+ZmRbMF0gKi8KKwkJZmRlbnRyeSA9IGZkdC0+
ZmQgKyAoZmQmbWFzayk7CisKKwkJLyogRG8gdGhlIGxvYWQsIHRoZW4gbWFzayBhbnkgaW52YWxp
ZCByZXN1bHQgKi8KKwkJZmlsZSA9IHJjdV9kZXJlZmVyZW5jZV9yYXcoKmZkZW50cnkpOworCQlm
aWxlID0gKHZvaWQgKikobWFzayAmICh1bnNpZ25lZCBsb25nKWZpbGUpOworCisJCWlmICh1bmxp
a2VseSghZmlsZSkpCiAJCQlyZXR1cm4gTlVMTDsKIAotCQlmZGVudHJ5ID0gZmR0LT5mZCArIGFy
cmF5X2luZGV4X25vc3BlYyhmZCwgZmR0LT5tYXhfZmRzKTsKKwkJLyoKKwkJICogT2ssIHdlIGhh
dmUgYSBmaWxlIHBvaW50ZXIgdGhhdCB3YXMgdmFsaWQgYXQKKwkJICogc29tZSBwb2ludCwgYnV0
IGl0IG1pZ2h0IGhhdmUgYmVjb21lIHN0YWxlIHNpbmNlLgorCQkgKgorCQkgKiBXZSBuZWVkIHRv
IGNvbmZpcm0gaXQgYnkgaW5jcmVtZW50aW5nIHRoZSByZWZjb3VudAorCQkgKiBhbmQgdGhlbiBj
aGVjayB0aGUgbG9va3VwIGFnYWluLgorCQkgKgorCQkgKiBhdG9taWNfbG9uZ19pbmNfbm90X3pl
cm8oKSBnaXZlcyB1cyBhIGZ1bGwgbWVtb3J5CisJCSAqIGJhcnJpZXIuIFdlIG9ubHkgcmVhbGx5
IG5lZWQgYW4gJ2FjcXVpcmUnIG9uZSB0bworCQkgKiBwcm90ZWN0IHRoZSBsb2FkcyBiZWxvdywg
YnV0IHdlIGRvbid0IGhhdmUgdGhhdC4KKwkJICovCisJCWlmICh1bmxpa2VseSghYXRvbWljX2xv
bmdfaW5jX25vdF96ZXJvKCZmaWxlLT5mX2NvdW50KSkpCisJCQljb250aW51ZTsKIAogCQkvKgot
CQkgKiBPaywgd2UgaGF2ZSBhIGZpbGUgcG9pbnRlci4gSG93ZXZlciwgYmVjYXVzZSB3ZSBkbwot
CQkgKiB0aGlzIGFsbCBsb2NrbGVzc2x5IHVuZGVyIFJDVSwgd2UgbWF5IGJlIHJhY2luZyB3aXRo
Ci0JCSAqIHRoYXQgZmlsZSBiZWluZyBjbG9zZWQuCi0JCSAqCiAJCSAqIFN1Y2ggYSByYWNlIGNh
biB0YWtlIHR3byBmb3JtczoKIAkJICoKIAkJICogIChhKSB0aGUgZmlsZSByZWYgYWxyZWFkeSB3
ZW50IGRvd24gdG8gemVybyBhbmQgdGhlCiAJCSAqICAgICAgZmlsZSBoYXNuJ3QgYmVlbiByZXVz
ZWQgeWV0IG9yIHRoZSBmaWxlIGNvdW50CiAJCSAqICAgICAgaXNuJ3QgemVybyBidXQgdGhlIGZp
bGUgaGFzIGFscmVhZHkgYmVlbiByZXVzZWQuCi0JCSAqLwotCQlmaWxlID0gX19nZXRfZmlsZV9y
Y3UoZmRlbnRyeSk7Ci0JCWlmICh1bmxpa2VseSghZmlsZSkpCi0JCQlyZXR1cm4gTlVMTDsKLQot
CQlpZiAodW5saWtlbHkoSVNfRVJSKGZpbGUpKSkKLQkJCWNvbnRpbnVlOwotCi0JCS8qCisJCSAq
CiAJCSAqICAoYikgdGhlIGZpbGUgdGFibGUgZW50cnkgaGFzIGNoYW5nZWQgdW5kZXIgdXMuCiAJ
CSAqICAgICAgIE5vdGUgdGhhdCB3ZSBkb24ndCBuZWVkIHRvIHJlLWNoZWNrIHRoZSAnZmR0LT5m
ZCcKIAkJICogICAgICAgcG9pbnRlciBoYXZpbmcgY2hhbmdlZCwgYmVjYXVzZSBpdCBhbHdheXMg
Z29lcwpAQCAtOTkxLDcgKzEwMDIsOCBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBmaWxlICpfX2Zn
ZXRfZmlsZXNfcmN1KHN0cnVjdCBmaWxlc19zdHJ1Y3QgKmZpbGVzLAogCQkgKgogCQkgKiBJZiBz
bywgd2UgbmVlZCB0byBwdXQgb3VyIHJlZiBhbmQgdHJ5IGFnYWluLgogCQkgKi8KLQkJaWYgKHVu
bGlrZWx5KHJjdV9kZXJlZmVyZW5jZV9yYXcoZmlsZXMtPmZkdCkgIT0gZmR0KSkgeworCQlpZiAo
dW5saWtlbHkoZmlsZSAhPSByY3VfZGVyZWZlcmVuY2VfcmF3KCpmZGVudHJ5KSkgfHwKKwkJICAg
IHVubGlrZWx5KHJjdV9kZXJlZmVyZW5jZV9yYXcoZmlsZXMtPmZkdCkgIT0gZmR0KSkgewogCQkJ
ZnB1dChmaWxlKTsKIAkJCWNvbnRpbnVlOwogCQl9CkBAIC0xMTI4LDEzICsxMTQwLDEzIEBAIHN0
YXRpYyB1bnNpZ25lZCBsb25nIF9fZmdldF9saWdodCh1bnNpZ25lZCBpbnQgZmQsIGZtb2RlX3Qg
bWFzaykKIAkgKiBhdG9taWNfcmVhZF9hY3F1aXJlKCkgcGFpcnMgd2l0aCBhdG9taWNfZGVjX2Fu
ZF90ZXN0KCkgaW4KIAkgKiBwdXRfZmlsZXNfc3RydWN0KCkuCiAJICovCi0JaWYgKGF0b21pY19y
ZWFkX2FjcXVpcmUoJmZpbGVzLT5jb3VudCkgPT0gMSkgeworCWlmIChsaWtlbHkoYXRvbWljX3Jl
YWRfYWNxdWlyZSgmZmlsZXMtPmNvdW50KSA9PSAxKSkgewogCQlmaWxlID0gZmlsZXNfbG9va3Vw
X2ZkX3JhdyhmaWxlcywgZmQpOwogCQlpZiAoIWZpbGUgfHwgdW5saWtlbHkoZmlsZS0+Zl9tb2Rl
ICYgbWFzaykpCiAJCQlyZXR1cm4gMDsKIAkJcmV0dXJuICh1bnNpZ25lZCBsb25nKWZpbGU7CiAJ
fSBlbHNlIHsKLQkJZmlsZSA9IF9fZmdldChmZCwgbWFzayk7CisJCWZpbGUgPSBfX2ZnZXRfZmls
ZXMoZmlsZXMsIGZkLCBtYXNrKTsKIAkJaWYgKCFmaWxlKQogCQkJcmV0dXJuIDA7CiAJCXJldHVy
biBGRFBVVF9GUFVUIHwgKHVuc2lnbmVkIGxvbmcpZmlsZTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvZmR0YWJsZS5oIGIvaW5jbHVkZS9saW51eC9mZHRhYmxlLmgKaW5kZXggYmM0YzMyODdh
NjVlLi5hOGE4YjRkMjQ2MTkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZmR0YWJsZS5oCisr
KyBiL2luY2x1ZGUvbGludXgvZmR0YWJsZS5oCkBAIC04MywxMiArODMsMTcgQEAgc3RydWN0IGRl
bnRyeTsKIHN0YXRpYyBpbmxpbmUgc3RydWN0IGZpbGUgKmZpbGVzX2xvb2t1cF9mZF9yYXcoc3Ry
dWN0IGZpbGVzX3N0cnVjdCAqZmlsZXMsIHVuc2lnbmVkIGludCBmZCkKIHsKIAlzdHJ1Y3QgZmR0
YWJsZSAqZmR0ID0gcmN1X2RlcmVmZXJlbmNlX3JhdyhmaWxlcy0+ZmR0KTsKKwl1bnNpZ25lZCBs
b25nIG1hc2sgPSBhcnJheV9pbmRleF9tYXNrX25vc3BlYyhmZCwgZmR0LT5tYXhfZmRzKTsKKwlz
dHJ1Y3QgZmlsZSAqbmVlZHNfbWFza2luZzsKIAotCWlmIChmZCA8IGZkdC0+bWF4X2Zkcykgewot
CQlmZCA9IGFycmF5X2luZGV4X25vc3BlYyhmZCwgZmR0LT5tYXhfZmRzKTsKLQkJcmV0dXJuIHJj
dV9kZXJlZmVyZW5jZV9yYXcoZmR0LT5mZFtmZF0pOwotCX0KLQlyZXR1cm4gTlVMTDsKKwkvKgor
CSAqICdtYXNrJyBpcyB6ZXJvIGZvciBhbiBvdXQtb2YtYm91bmRzIGZkLCBhbGwgb25lcyBmb3Ig
b2suCisJICogJ2ZkfH5tYXNrJyBpcyAnZmQnIGZvciBvaywgb3IgMCBmb3Igb3V0IG9mIGJvdW5k
cy4KKwkgKgorCSAqIEFjY2Vzc2luZyBmZHQtPmZkWzBdIGlzIG9rLCBidXQgbmVlZHMgbWFza2lu
ZyBvZiB0aGUgcmVzdWx0LgorCSAqLworCW5lZWRzX21hc2tpbmcgPSByY3VfZGVyZWZlcmVuY2Vf
cmF3KGZkdC0+ZmRbZmQmbWFza10pOworCXJldHVybiAoc3RydWN0IGZpbGUgKikobWFzayAmICh1
bnNpZ25lZCBsb25nKW5lZWRzX21hc2tpbmcpOwogfQogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBm
aWxlICpmaWxlc19sb29rdXBfZmRfbG9ja2VkKHN0cnVjdCBmaWxlc19zdHJ1Y3QgKmZpbGVzLCB1
bnNpZ25lZCBpbnQgZmQpCg==
--00000000000009cc68060b13f8a2--
