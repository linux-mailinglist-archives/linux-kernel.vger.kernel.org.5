Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59869761EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjGYQi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGYQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:38:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14161BD9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:38:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99b78fda9a8so640716466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690303131; x=1690907931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/hV84gZ+D8xd/fmK5f/p7hKwVoFKgCpAZpTMIDw8ZDs=;
        b=bgw7yE97Te7uthzrLVKyHBHHe+wIcvdLDLgxLrrOS0pq+/PqCMgVqDy/SQK17zDrv/
         UBW65Gq2otagc1Wo9jdTqUikd7RZDNmSTp+vE31JY8X9jmafDt/oYQi9h8/nDK/lE3JY
         lKF2dBBfaVuHIlROFlSFX0Wv4yup48WbZpMVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690303131; x=1690907931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hV84gZ+D8xd/fmK5f/p7hKwVoFKgCpAZpTMIDw8ZDs=;
        b=hjVVS/g0Z+6Hxg255krp3vvSeEmNtMXOFoV53az9xEKEs/fQEmg23R5mO4eKazwcOv
         o24QClJDeudJN5GAvE7Z/DZE0yH4yfMPyxclh+k3laR+0THkUoorj3JLezmwTJUOYcf/
         SLWgGdNQPbkI74+uKUuqiSydzUgez3yRC8CEnHKqgGGfIJfbem4twceJnIXwt7Q3cxZM
         PbwYeyM0Byx1G2YmDBwMBYEaeQFKli381zg60vWgogmJnvkQPPplWGo4iLU74OAIWP7j
         Zh/YgMgFiaxxw/sFiPO5KA5gFlXxKq9C4wzTAAwDOgqM1qGd8qdM+HwPu1pgGp/5oX7O
         Mkog==
X-Gm-Message-State: ABy/qLYHlubtw9yZ7Q5pBJICT4OHfNaFzQJA4iJzdCkpoVF8ShvD3wT9
        GYSnTPxxI4iThX1pMH1Fis8W5twLOMnnLhM9fvaTYMO+
X-Google-Smtp-Source: APBJJlEQs1lU2ySkHrr2aGeaOB+H/h1ofAG9SsRLvu4CT6arpTu31ZGliyi11h4fyu1qcwJ19j91TQ==
X-Received: by 2002:a17:907:2cef:b0:99b:4a6f:9c72 with SMTP id hz15-20020a1709072cef00b0099b4a6f9c72mr15395959ejc.72.1690303130962;
        Tue, 25 Jul 2023 09:38:50 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709067d9100b0098d2261d189sm8513613ejo.19.2023.07.25.09.38.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 09:38:50 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5221b90f763so5163078a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:38:50 -0700 (PDT)
X-Received: by 2002:aa7:d707:0:b0:522:3149:1596 with SMTP id
 t7-20020aa7d707000000b0052231491596mr5134940edq.13.1690303129829; Tue, 25 Jul
 2023 09:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <8d063a26-43f5-0bb7-3203-c6a04dc159f8@proxmox.com>
In-Reply-To: <8d063a26-43f5-0bb7-3203-c6a04dc159f8@proxmox.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jul 2023 09:38:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKBx_UUKagfyF72EJrpqNCupF4yeoPgapjEBe1bynGcw@mail.gmail.com>
Message-ID: <CAHk-=whKBx_UUKagfyF72EJrpqNCupF4yeoPgapjEBe1bynGcw@mail.gmail.com>
Subject: Re: segfaults of processes while being killed after commit "mm: make
 the page fault mmap locking killable"
To:     Fiona Ebner <f.ebner@proxmox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     akpm@linux-foundation.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009e069c0601525dd0"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009e069c0601525dd0
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jul 2023 at 04:16, Fiona Ebner <f.ebner@proxmox.com> wrote:
>
> will end up without a vma and cause/log the segfault. Of course the
> process is already being killed, but I'd argue it is very confusing to
> users when apparent segfaults from such processes are being logged by
> the kernel.

Ahh. Yes, that wasn't the intent. A process that is being killed
should exit with the lethal signal, not SIGSEGV.

This is not new, btw - this situation is exactly the same as if you
use something like NFS where the process is killed and the IO is
interrupted and the page fault faults for that reason.

But I suspect *very* few people actually encounter that NFS situation
(you can get it on local filesystems too, but the IO race window is
then so small as to probably not be triggerable at all).

So the new killable() check is probably much easier to actually
trigger in practice, even though it's not a new situation per se.

What exactly made you notice? Is it just the logging from
'show_unhandled_signals' being set?

Because the actual signal itself, from the

        force_sig_fault(SIGSEGV, si_code, (void __user *)address);

in __bad_area_nosemaphore() should be overridden by the fact that a
lethal signal was already pending.

But let's add a couple of signal people rather than the mm people to
the participants. Eric, Oleg - would not an existing fatal signal take
precedence over a new SIGSEGV? I obviously thought it did, but looking
at 'get_signal()' and the signal delivery, I don't actually see any
code to that effect.

Fiona - that patch is easily reverted, and it was done as a separate
patch exactly because I was wondering if there was some subtle reason
we didn't already do that.

But before we revert it, would you mind trying out the attached
trivial patch instead?

I'd also still be interested if the symptoms were anything else than
'show_unhandled_signals' causing the show_signal_msg() dance, and
resulting in a message something like

    a.out[1567]: segfault at xyz ip [..] likely on CPU X

in dmesg...

                 Linus

--0000000000009e069c0601525dd0
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lkiims3u0>
X-Attachment-Id: f_lkiims3u0

IGFyY2gveDg2L21tL2ZhdWx0LmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9mYXVsdC5jIGIvYXJjaC94ODYvbW0vZmF1
bHQuYwppbmRleCBlODcxMWIyY2FmYWYuLmI0YTAyOTBlOTYzYyAxMDA2NDQKLS0tIGEvYXJjaC94
ODYvbW0vZmF1bHQuYworKysgYi9hcmNoL3g4Ni9tbS9mYXVsdC5jCkBAIC04MzEsNiArODMxLDEw
IEBAIF9fYmFkX2FyZWFfbm9zZW1hcGhvcmUoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHVuc2lnbmVk
IGxvbmcgZXJyb3JfY29kZSwKIAkgKi8KIAlsb2NhbF9pcnFfZW5hYmxlKCk7CiAKKwkvKiBJZiBh
IGZhdGFsIHNpZ25hbCBpcyBwZW5kaW5nLCBkb24ndCBib3RoZXIgd2l0aCBhbnl0aGluZyBlbHNl
ICovCisJaWYgKGZhdGFsX3NpZ25hbF9wZW5kaW5nKCkpCisJCXJldHVybjsKKwogCS8qCiAJICog
VmFsaWQgdG8gZG8gYW5vdGhlciBwYWdlIGZhdWx0IGhlcmUgYmVjYXVzZSB0aGlzIG9uZSBjYW1l
CiAJICogZnJvbSB1c2VyIHNwYWNlOgo=
--0000000000009e069c0601525dd0--
