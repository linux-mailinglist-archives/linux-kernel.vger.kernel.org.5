Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E07A26E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjIOTHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbjIOTGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:06:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C20FB2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:06:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 38308e7fff4ca-2bfb1167277so40712831fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694804805; x=1695409605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zXGgjYhJRVNXafG9EaDgNWKV0uGtY61wiPn89e1hCdo=;
        b=HgZTrzJAorYzXFJCksJ2czE4QYLWVP5Ila+LkOps10hKmM0GzRbpdzs6UcYiek0ibn
         couJWkI9yXTr/igqyH7MclCGq9KPO77unYKKuxrDWe/YcqcIwLfb6TKPLnQBvBM9nrTf
         styPgbvNImI8/lW0+jpyJz65GEIGcohmWFuFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804805; x=1695409605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXGgjYhJRVNXafG9EaDgNWKV0uGtY61wiPn89e1hCdo=;
        b=QONYz+4tj2xScOlVDbRGD1oFGjla26JoCRupEMlKci3Fx92ridtY+HFqsrxdPf1AV8
         bavNq6gTYf1DGNqbb1VqwOsNBOrvAEx+h1ca8IkfTNLGNl9S3jNqQxbXh+DmTW8Qns+J
         z7buPj/L4oQIvfdVGYQKlTc+tZd7NsthETF1tlVyLk88q1oF9r/PStdn3vo3A+rfxaIe
         f2OO0uyiJMZ4TAWDApzTuYGpzsRo7lsdrzOuSlOJqnryHc9riw4vdCdxabyOcDNYyaw1
         p3v9Y91a9Euq19LHdS95WGQHw4t1G+rFD+3BNweANFUtNOcaOQ7I49PgIEaDUEL3WmL/
         x/2A==
X-Gm-Message-State: AOJu0Yw5k/E1hYenZ8Rus0ICc13zXbMmeU6bDh4FD3hfpzx76S/MTKEh
        KOgCcekyz9sOXu+/77BLX8FIJktKVMMtEGeALZ+asWfu1No=
X-Google-Smtp-Source: AGHT+IEc27C79nTkt1QDOF4UwzQFb0mPCKf5wV3frDXV+ya2iUm77HqO1kszXAzKq2rjgaSc1ruFNA==
X-Received: by 2002:a2e:a178:0:b0:2ba:6519:c50f with SMTP id u24-20020a2ea178000000b002ba6519c50fmr2287050ljl.52.1694804805225;
        Fri, 15 Sep 2023 12:06:45 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id n14-20020a2eb78e000000b002bbacc6c523sm829008ljo.49.2023.09.15.12.06.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 12:06:44 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-502f302b68dso1807020e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:06:43 -0700 (PDT)
X-Received: by 2002:ac2:4eca:0:b0:500:761b:72ff with SMTP id
 p10-20020ac24eca000000b00500761b72ffmr2487633lfr.55.1694804803468; Fri, 15
 Sep 2023 12:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183> <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
In-Reply-To: <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 12:06:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
Message-ID: <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
Subject: Re: Buggy __free(kfree) usage pattern already in tree
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Content-Type: multipart/mixed; boundary="00000000000047205b06056a7e38"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000047205b06056a7e38
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Sept 2023 at 10:22, Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
> IMO this feature has much more potential at fixing existing memory
> leaks than introducing new ones. I agree, I should have been more
> careful, but I wouldn't exaggerate the issue. It's a bug, I sent a
> fix, it'll be fine in a few days. I hope it won't be seen as an
> argument against __free(). It just needs some time to mature.

Honestly, I think your "fix" is still wrong.

It may *work*, but it's against the whole spirit of having an
allocation paired with the "this is how you free it".

Your model of is fundamentally fragile, and honestly, it's disgusting.

The fact that you literally have

        char ***line_names

as an argument should have made you wonder. Yes, we have triple
indirect pointers in some other parts of the tree, but it sure isn't a
"feature".

The thing is, your cleanup function should mirror your allocation
function. It didn't, and it caused a bug.

And it STILL DOES NOT, even with your change.

So I claim you are completely mis-using the whole __free thing. What
you are doing is simply WRONG.

And unless you can do it right, I will revert that change of yours to
mis-use the cleanup functions, because I do not want anybody else to
look at your code and get all the wrong ideas.

Seriously.

So look at your code, and DO IT RIGHT. Don't try to claim that
"kfree()" is the cleanup function for gpio_sim_make_line_names().
Because it really isn't. One free's a random pointer. Another returns
a complex data structure *and* a count. They aren't inverses.

I don't care ONE WHIT if you have learnt to use these kinds of things
from GLib/GObject, and if that kind of disgusting behavior is ok
there.

It's not going to fly in the kernel.

So your pattern needs to be something like this:

        struct X *p __free(freeXYZ) = allocXYZ();

and ABSOLUTELY NOTHING ELSE.  So if you use __free(kfree), it looks like

        struct obj *p __free(kfree) = kmalloc(...);

and not some different variation of it.

And if you want to do something more complex, we literally have that
"CLASS()" abstraction to make the above pattern particularly easy to
use. Use it.

But don't abuse the very special 'kmalloc/kfree' class that we have as
an example. That's for kmalloc/kfree pairs, not for your "char
***line_names" thing.

Now, Just to give you a very concrete example, here are two TOTALLY
UNTESTED patches.

I wrote two, because there's two ways to fix this properly as per
above, and use those functions properly.

The *SANE* way is to just re-organize the code to count things
separately, and then you can allocate it properly with a sane

    char **line_names __free(kfree) = kcalloc(lines,
sizeof(*line_names), GFP_KERNEL);

and not have that crazy "count and fill and return both the count and
the lines" model at all. The above pairs the constructor and
destructor correctly and clearly.

So that's the first "maybe-sane.diff" version. It may be untested,
it's probably still buggy due to that, but it is what I *think* you
should model the real fix around.

The second patch is WAY overkill, and actually creates a "class" for
this all, and keeps the old broken "count and fill in one go", and
returns that *one* value that is just the class, and has a destructor
for that class etc etc.

It's completely broken and ridiculously over-complicated for something
like this, but it's trying to document that way of doing things. For
other things that aren't just one-offs, that whole CLASS() model may
be the right one.

Either of these patches *might* work, but honestly, both of them are
likely broken. The second one in particular is almost certainly buggy
just because it's such a crazy overkill solution, but partly *because*
of how crazy overkill it is, I think it might be a useful example of
what *can* be done.

Again: UNTESTED. They both build for me, but that doesn't say much.

                Linus

--00000000000047205b06056a7e38
Content-Type: text/x-patch; charset="US-ASCII"; name="maybe-sane.diff"
Content-Disposition: attachment; filename="maybe-sane.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lmkytv5x0>
X-Attachment-Id: f_lmkytv5x0

IGRyaXZlcnMvZ3Bpby9ncGlvLXNpbS5jIHwgNjIgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyks
IDM4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3Bpby9ncGlvLXNpbS5jIGIv
ZHJpdmVycy9ncGlvL2dwaW8tc2ltLmMKaW5kZXggMjcxZGIzNjM5YTc4Li5kNTA2ZDVkMzRjMDkg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlvLXNpbS5jCisrKyBiL2RyaXZlcnMvZ3Bpby9n
cGlvLXNpbS5jCkBAIC02ODUsNTIgKzY4NSwzNSBAQCBncGlvX3NpbV9kZXZpY2VfY29uZmlnX2xp
dmVfc2hvdyhzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sIGNoYXIgKnBhZ2UpCiAJcmV0dXJuIHNw
cmludGYocGFnZSwgIiVjXG4iLCBsaXZlID8gJzEnIDogJzAnKTsKIH0KIAotc3RhdGljIGNoYXIg
KipncGlvX3NpbV9tYWtlX2xpbmVfbmFtZXMoc3RydWN0IGdwaW9fc2ltX2JhbmsgKmJhbmssCi0J
CQkJICAgICAgIHVuc2lnbmVkIGludCAqbGluZV9uYW1lc19zaXplKQorc3RhdGljIHVuc2lnbmVk
IGludCBncGlvX3NpbV9jb3VudF9saW5lcyhzdHJ1Y3QgZ3Bpb19zaW1fYmFuayAqYmFuaykKIHsK
IAl1bnNpZ25lZCBpbnQgbWF4X29mZnNldCA9IDA7Ci0JYm9vbCBoYXNfbGluZV9uYW1lcyA9IGZh
bHNlOwogCXN0cnVjdCBncGlvX3NpbV9saW5lICpsaW5lOwotCWNoYXIgKipsaW5lX25hbWVzOwog
CiAJbGlzdF9mb3JfZWFjaF9lbnRyeShsaW5lLCAmYmFuay0+bGluZV9saXN0LCBzaWJsaW5ncykg
ewogCQlpZiAobGluZS0+b2Zmc2V0ID49IGJhbmstPm51bV9saW5lcykKIAkJCWNvbnRpbnVlOwot
Ci0JCWlmIChsaW5lLT5uYW1lKSB7Ci0JCQlpZiAobGluZS0+b2Zmc2V0ID4gbWF4X29mZnNldCkK
LQkJCQltYXhfb2Zmc2V0ID0gbGluZS0+b2Zmc2V0OwotCi0JCQkvKgotCQkJICogbWF4X29mZnNl
dCBjYW4gc3RheSBhdCAwIHNvIGl0J3Mgbm90IGFuIGluZGljYXRvcgotCQkJICogb2Ygd2hldGhl
ciBsaW5lIG5hbWVzIHdlcmUgY29uZmlndXJlZCBhdCBhbGwuCi0JCQkgKi8KLQkJCWhhc19saW5l
X25hbWVzID0gdHJ1ZTsKLQkJfQorCQlpZiAoIWxpbmUtPm5hbWUpCisJCQljb250aW51ZTsKKwkJ
aWYgKGxpbmUtPm9mZnNldCA8IG1heF9vZmZzZXQpCisJCQljb250aW51ZTsKKwkJbWF4X29mZnNl
dCA9IGxpbmUtPm9mZnNldCArIDE7CiAJfQogCi0JaWYgKCFoYXNfbGluZV9uYW1lcykKLQkJLyoK
LQkJICogVGhpcyBpcyBub3QgYW4gZXJyb3IgLSBOVUxMIG1lYW5zLCB0aGVyZSBhcmUgbm8gbGlu
ZQotCQkgKiBuYW1lcyBjb25maWd1cmVkLgotCQkgKi8KLQkJcmV0dXJuIE5VTEw7CisJcmV0dXJu
IG1heF9vZmZzZXQ7Cit9CiAKLQkqbGluZV9uYW1lc19zaXplID0gbWF4X29mZnNldCArIDE7Ci0K
LQlsaW5lX25hbWVzID0ga2NhbGxvYygqbGluZV9uYW1lc19zaXplLCBzaXplb2YoKmxpbmVfbmFt
ZXMpLCBHRlBfS0VSTkVMKTsKLQlpZiAoIWxpbmVfbmFtZXMpCi0JCXJldHVybiBFUlJfUFRSKC1F
Tk9NRU0pOworc3RhdGljIHZvaWQgZ3Bpb19zaW1fZmlsbF9saW5lX25hbWVzKHN0cnVjdCBncGlv
X3NpbV9iYW5rICpiYW5rLCBjaGFyICoqbGluZV9uYW1lcykKK3sKKwlzdHJ1Y3QgZ3Bpb19zaW1f
bGluZSAqbGluZTsKIAogCWxpc3RfZm9yX2VhY2hfZW50cnkobGluZSwgJmJhbmstPmxpbmVfbGlz
dCwgc2libGluZ3MpIHsKIAkJaWYgKGxpbmUtPm9mZnNldCA+PSBiYW5rLT5udW1fbGluZXMpCiAJ
CQljb250aW51ZTsKLQotCQlpZiAobGluZS0+bmFtZSAmJiAobGluZS0+b2Zmc2V0IDw9IG1heF9v
ZmZzZXQpKQotCQkJbGluZV9uYW1lc1tsaW5lLT5vZmZzZXRdID0gbGluZS0+bmFtZTsKKwkJaWYg
KCFsaW5lLT5uYW1lKQorCQkJY29udGludWU7CisJCWxpbmVfbmFtZXNbbGluZS0+b2Zmc2V0XSA9
IGxpbmUtPm5hbWU7CiAJfQotCi0JcmV0dXJuIGxpbmVfbmFtZXM7CiB9CiAKIHN0YXRpYyB2b2lk
IGdwaW9fc2ltX3JlbW92ZV9ob2dzKHN0cnVjdCBncGlvX3NpbV9kZXZpY2UgKmRldikKQEAgLTgz
NCw4ICs4MTcsNyBAQCBncGlvX3NpbV9tYWtlX2Jhbmtfc3dub2RlKHN0cnVjdCBncGlvX3NpbV9i
YW5rICpiYW5rLAogCQkJICBzdHJ1Y3QgZndub2RlX2hhbmRsZSAqcGFyZW50KQogewogCXN0cnVj
dCBwcm9wZXJ0eV9lbnRyeSBwcm9wZXJ0aWVzW0dQSU9fU0lNX1BST1BfTUFYXTsKLQl1bnNpZ25l
ZCBpbnQgcHJvcF9pZHggPSAwLCBsaW5lX25hbWVzX3NpemUgPSAwOwotCWNoYXIgKipsaW5lX25h
bWVzIF9fZnJlZShrZnJlZSkgPSBOVUxMOworCXVuc2lnbmVkIGludCBwcm9wX2lkeCA9IDAsIGxp
bmVzOwogCiAJbWVtc2V0KHByb3BlcnRpZXMsIDAsIHNpemVvZihwcm9wZXJ0aWVzKSk7CiAKQEAg
LTg0NSwxNCArODI3LDE4IEBAIGdwaW9fc2ltX21ha2VfYmFua19zd25vZGUoc3RydWN0IGdwaW9f
c2ltX2JhbmsgKmJhbmssCiAJCXByb3BlcnRpZXNbcHJvcF9pZHgrK10gPSBQUk9QRVJUWV9FTlRS
WV9TVFJJTkcoImdwaW8tc2ltLGxhYmVsIiwKIAkJCQkJCQkgICAgICAgYmFuay0+bGFiZWwpOwog
Ci0JbGluZV9uYW1lcyA9IGdwaW9fc2ltX21ha2VfbGluZV9uYW1lcyhiYW5rLCAmbGluZV9uYW1l
c19zaXplKTsKLQlpZiAoSVNfRVJSKGxpbmVfbmFtZXMpKQotCQlyZXR1cm4gRVJSX0NBU1QobGlu
ZV9uYW1lcyk7CisJbGluZXMgPSBncGlvX3NpbV9jb3VudF9saW5lcyhiYW5rKTsKKwljaGFyICoq
bGluZV9uYW1lcyBfX2ZyZWUoa2ZyZWUpID0ga2NhbGxvYyhsaW5lcywgc2l6ZW9mKCpsaW5lX25h
bWVzKSwgR0ZQX0tFUk5FTCk7CiAKLQlpZiAobGluZV9uYW1lcykKKwlpZiAoIWxpbmVfbmFtZXMp
CisJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOworCisJZ3Bpb19zaW1fZmlsbF9saW5lX25hbWVz
KGJhbmssIGxpbmVfbmFtZXMpOworCisJaWYgKGxpbmVzKQogCQlwcm9wZXJ0aWVzW3Byb3BfaWR4
KytdID0gUFJPUEVSVFlfRU5UUllfU1RSSU5HX0FSUkFZX0xFTigKIAkJCQkJCSJncGlvLWxpbmUt
bmFtZXMiLAotCQkJCQkJbGluZV9uYW1lcywgbGluZV9uYW1lc19zaXplKTsKKwkJCQkJCWxpbmVf
bmFtZXMsIGxpbmVzKTsKIAogCXJldHVybiBmd25vZGVfY3JlYXRlX3NvZnR3YXJlX25vZGUocHJv
cGVydGllcywgcGFyZW50KTsKIH0K
--00000000000047205b06056a7e38
Content-Type: text/x-patch; charset="US-ASCII"; name="silly.diff"
Content-Disposition: attachment; filename="silly.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lmkyu11w1>
X-Attachment-Id: f_lmkyu11w1

IGRyaXZlcnMvZ3Bpby9ncGlvLXNpbS5jIHwgNTYgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyks
IDE4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3Bpby9ncGlvLXNpbS5jIGIv
ZHJpdmVycy9ncGlvL2dwaW8tc2ltLmMKaW5kZXggMjcxZGIzNjM5YTc4Li5hYzg0MTZjZDk2YzMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3Bpby9ncGlvLXNpbS5jCisrKyBiL2RyaXZlcnMvZ3Bpby9n
cGlvLXNpbS5jCkBAIC02ODUsMTMgKzY4NSwzNiBAQCBncGlvX3NpbV9kZXZpY2VfY29uZmlnX2xp
dmVfc2hvdyhzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sIGNoYXIgKnBhZ2UpCiAJcmV0dXJuIHNw
cmludGYocGFnZSwgIiVjXG4iLCBsaXZlID8gJzEnIDogJzAnKTsKIH0KIAotc3RhdGljIGNoYXIg
KipncGlvX3NpbV9tYWtlX2xpbmVfbmFtZXMoc3RydWN0IGdwaW9fc2ltX2JhbmsgKmJhbmssCi0J
CQkJICAgICAgIHVuc2lnbmVkIGludCAqbGluZV9uYW1lc19zaXplKQorc3RydWN0IGxpbmVfbmFt
ZXMgeworCXVuc2lnbmVkIGludCBzaXplOworCWNoYXIgKipsaW5lczsKK307CisKK3N0YXRpYyBz
dHJ1Y3QgbGluZV9uYW1lcyBtYWtlX2xpbmVfbmFtZXModW5zaWduZWQgaW50IHNpemUpCit7CisJ
Y2hhciAqKmxpbmVzID0ga2NhbGxvYyhzaXplLCBzaXplb2YoKmxpbmVzKSwgR0ZQX0tFUk5FTCk7
CisJaWYgKCFsaW5lcykKKwkJcmV0dXJuIChzdHJ1Y3QgbGluZV9uYW1lcykgeyAwLCBFUlJfUFRS
KC1FTk9NRU0pIH07CisKKwlyZXR1cm4gKHN0cnVjdCBsaW5lX25hbWVzKSB7IHNpemUsIGxpbmVz
IH07Cit9CisKK3N0YXRpYyB2b2lkIGZyZWVfbGluZV9uYW1lcyhzdHJ1Y3QgbGluZV9uYW1lcyBu
YW1lcykKK3sKKwlpZiAoIUlTX0VSUl9PUl9OVUxMKG5hbWVzLmxpbmVzKSkKKwkJa2ZyZWUobmFt
ZXMubGluZXMpOworfQorCitERUZJTkVfQ0xBU1MobGluZV9uYW1lcywKKwlzdHJ1Y3QgbGluZV9u
YW1lcywKKwlmcmVlX2xpbmVfbmFtZXMoX1QpLAorCW1ha2VfbGluZV9uYW1lcyhzaXplKSwgdW5z
aWduZWQgaW50IHNpemUpCisKK3N0YXRpYyBzdHJ1Y3QgbGluZV9uYW1lcyBncGlvX3NpbV9tYWtl
X2xpbmVfbmFtZXMoc3RydWN0IGdwaW9fc2ltX2JhbmsgKmJhbmspCiB7CiAJdW5zaWduZWQgaW50
IG1heF9vZmZzZXQgPSAwOwogCWJvb2wgaGFzX2xpbmVfbmFtZXMgPSBmYWxzZTsKIAlzdHJ1Y3Qg
Z3Bpb19zaW1fbGluZSAqbGluZTsKLQljaGFyICoqbGluZV9uYW1lczsKIAogCWxpc3RfZm9yX2Vh
Y2hfZW50cnkobGluZSwgJmJhbmstPmxpbmVfbGlzdCwgc2libGluZ3MpIHsKIAkJaWYgKGxpbmUt
Pm9mZnNldCA+PSBiYW5rLT5udW1fbGluZXMpCkBAIC03MTQsMjMgKzczNywyMSBAQCBzdGF0aWMg
Y2hhciAqKmdwaW9fc2ltX21ha2VfbGluZV9uYW1lcyhzdHJ1Y3QgZ3Bpb19zaW1fYmFuayAqYmFu
aywKIAkJICogVGhpcyBpcyBub3QgYW4gZXJyb3IgLSBOVUxMIG1lYW5zLCB0aGVyZSBhcmUgbm8g
bGluZQogCQkgKiBuYW1lcyBjb25maWd1cmVkLgogCQkgKi8KLQkJcmV0dXJuIE5VTEw7CisJCXJl
dHVybiAoc3RydWN0IGxpbmVfbmFtZXMpIHsgMCwgTlVMTCB9OwogCi0JKmxpbmVfbmFtZXNfc2l6
ZSA9IG1heF9vZmZzZXQgKyAxOwotCi0JbGluZV9uYW1lcyA9IGtjYWxsb2MoKmxpbmVfbmFtZXNf
c2l6ZSwgc2l6ZW9mKCpsaW5lX25hbWVzKSwgR0ZQX0tFUk5FTCk7Ci0JaWYgKCFsaW5lX25hbWVz
KQotCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKKwlDTEFTUyhsaW5lX25hbWVzLCBuYW1lcyko
bWF4X29mZnNldCArIDEpOworCWlmIChJU19FUlIobmFtZXMubGluZXMpKQorCQlyZXR1cm4gbmFt
ZXM7CiAKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGxpbmUsICZiYW5rLT5saW5lX2xpc3QsIHNpYmxp
bmdzKSB7CiAJCWlmIChsaW5lLT5vZmZzZXQgPj0gYmFuay0+bnVtX2xpbmVzKQogCQkJY29udGlu
dWU7CiAKIAkJaWYgKGxpbmUtPm5hbWUgJiYgKGxpbmUtPm9mZnNldCA8PSBtYXhfb2Zmc2V0KSkK
LQkJCWxpbmVfbmFtZXNbbGluZS0+b2Zmc2V0XSA9IGxpbmUtPm5hbWU7CisJCQluYW1lcy5saW5l
c1tsaW5lLT5vZmZzZXRdID0gbGluZS0+bmFtZTsKIAl9CiAKLQlyZXR1cm4gbGluZV9uYW1lczsK
KwlyZXR1cm4gKHN0cnVjdCBsaW5lX25hbWVzKSB7IG5hbWVzLnNpemUsIG5vX2ZyZWVfcHRyKG5h
bWVzLmxpbmVzKSB9OwogfQogCiBzdGF0aWMgdm9pZCBncGlvX3NpbV9yZW1vdmVfaG9ncyhzdHJ1
Y3QgZ3Bpb19zaW1fZGV2aWNlICpkZXYpCkBAIC04MzQsOCArODU1LDcgQEAgZ3Bpb19zaW1fbWFr
ZV9iYW5rX3N3bm9kZShzdHJ1Y3QgZ3Bpb19zaW1fYmFuayAqYmFuaywKIAkJCSAgc3RydWN0IGZ3
bm9kZV9oYW5kbGUgKnBhcmVudCkKIHsKIAlzdHJ1Y3QgcHJvcGVydHlfZW50cnkgcHJvcGVydGll
c1tHUElPX1NJTV9QUk9QX01BWF07Ci0JdW5zaWduZWQgaW50IHByb3BfaWR4ID0gMCwgbGluZV9u
YW1lc19zaXplID0gMDsKLQljaGFyICoqbGluZV9uYW1lcyBfX2ZyZWUoa2ZyZWUpID0gTlVMTDsK
Kwl1bnNpZ25lZCBpbnQgcHJvcF9pZHggPSAwOwogCiAJbWVtc2V0KHByb3BlcnRpZXMsIDAsIHNp
emVvZihwcm9wZXJ0aWVzKSk7CiAKQEAgLTg0NSwxNCArODY1LDE0IEBAIGdwaW9fc2ltX21ha2Vf
YmFua19zd25vZGUoc3RydWN0IGdwaW9fc2ltX2JhbmsgKmJhbmssCiAJCXByb3BlcnRpZXNbcHJv
cF9pZHgrK10gPSBQUk9QRVJUWV9FTlRSWV9TVFJJTkcoImdwaW8tc2ltLGxhYmVsIiwKIAkJCQkJ
CQkgICAgICAgYmFuay0+bGFiZWwpOwogCi0JbGluZV9uYW1lcyA9IGdwaW9fc2ltX21ha2VfbGlu
ZV9uYW1lcyhiYW5rLCAmbGluZV9uYW1lc19zaXplKTsKLQlpZiAoSVNfRVJSKGxpbmVfbmFtZXMp
KQotCQlyZXR1cm4gRVJSX0NBU1QobGluZV9uYW1lcyk7CisJY2xhc3NfbGluZV9uYW1lc190IG5h
bWVzIF9fY2xlYW51cChjbGFzc19saW5lX25hbWVzX2Rlc3RydWN0b3IpID0gZ3Bpb19zaW1fbWFr
ZV9saW5lX25hbWVzKGJhbmspOworCWlmIChJU19FUlIobmFtZXMubGluZXMpKQorCQlyZXR1cm4g
RVJSX0NBU1QobmFtZXMubGluZXMpOwogCi0JaWYgKGxpbmVfbmFtZXMpCisJaWYgKG5hbWVzLnNp
emUpCiAJCXByb3BlcnRpZXNbcHJvcF9pZHgrK10gPSBQUk9QRVJUWV9FTlRSWV9TVFJJTkdfQVJS
QVlfTEVOKAogCQkJCQkJImdwaW8tbGluZS1uYW1lcyIsCi0JCQkJCQlsaW5lX25hbWVzLCBsaW5l
X25hbWVzX3NpemUpOworCQkJCQkJbmFtZXMubGluZXMsIG5hbWVzLnNpemUpOwogCiAJcmV0dXJu
IGZ3bm9kZV9jcmVhdGVfc29mdHdhcmVfbm9kZShwcm9wZXJ0aWVzLCBwYXJlbnQpOwogfQo=
--00000000000047205b06056a7e38--
