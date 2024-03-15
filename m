Return-Path: <linux-kernel+bounces-104695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7085987D278
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE9285045
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32BE3EA97;
	Fri, 15 Mar 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QeBZNuks"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50412E71
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522622; cv=none; b=p8HyhOL+9VJMWr/To3LuZubeo9cWHElzPdeuvG1FR+tp3r1ZeBXC0q/FdACdYCp98aNm/dsbWCHbF6VWbLMt/xN4VpGfrFLmlC5LXfnTpXh9bDjtgA4sT2A5/GzUnQno92+Nt47Qx1VJZa61r0Zk2ZNW/Kp1VZAwvIjbIHJoV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522622; c=relaxed/simple;
	bh=6DEC6oUBwOJ1z2N6TU7EEu2WviwhfCWFHXvtFC7nPjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRsD2rYikNofdbC30FWcZ3KfYKf04tpdqOg3lHklD7OKvitibZBJfjo6Qnk6pt2RMK+SJsMe5NdZb8TrG3JIjZijJR7x4lEgfQxLzjoKSIpCWoICzQd7ZGA1xiSHE0JwRW7HoX+21ag/4QeB0x5g4mElIKNGdz7NPp1CLss/PqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QeBZNuks; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44ad785a44so279050866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710522618; x=1711127418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NlJklAI6AGoIIJ5Y8J8C9xRkI2A04dQCtN2O9+qMSZk=;
        b=QeBZNuksWRcPxpO9NIAwtx0pm1gW1mMbjZGqHlqY8qLy6k5KawVg9WknHTgugak1TC
         SZoI45yiJdfrecXtctkQjxDeEZxkoonGID4laY4PW66E07T98ImHetQQKQhk6jNjikgr
         BtOKHxqYYaIuUrHwj/cOy9GHqY6nOj0I7QT44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710522618; x=1711127418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlJklAI6AGoIIJ5Y8J8C9xRkI2A04dQCtN2O9+qMSZk=;
        b=rvScK09YBeNhRdhtKc2MQ4vuYoAw7NpDLH9DsoZpFI3o4LReFkW+f0TdfFYiJffnV4
         SVJcvc21jzyQP5YcLArv1Lvuuso16bbuPe5XYZ7CWuOdSAEPDrAo8FfcPd7AhGZg+u9U
         anC5/Tlpqc1/NLxoC2HB5SSwVQEh1f/CMFpo/frYWG0/91dY2Fjz22aeOZitho+fZ0J3
         UF1XWYUFoJkDmgGoG6d1NxLdrfr1u+hWAfcrZ35t92OpKD4yVeFM2MNfyjAD3gobZPDP
         qojS/wlUhd8WziszGbi2CIAm7OsYlezKyBw4LAvjM97geQSqmr1JztjtCxPObZQ3p8R0
         eHoA==
X-Gm-Message-State: AOJu0YyjPRlkmS3VKHtEeif27+3bk8Cy+m6H3UZw1crJ+HRgoaicKFzI
	bT0KPP39ILxtCS+Tiro1LuJG2YrSQltrNv4tehH2+NMkBRA1Ft2mW2p0L53dxDPVTO243jQTiaD
	uJtI=
X-Google-Smtp-Source: AGHT+IGFUclY0dpUFNhxqlUwa7DL1GMXyKHUDbRdB3Ekc3AOaJytHVeHlvu0KXVnB0UjBKASl9ELPg==
X-Received: by 2002:a17:907:208a:b0:a46:636a:2c23 with SMTP id pv10-20020a170907208a00b00a46636a2c23mr2851500ejb.34.1710522617665;
        Fri, 15 Mar 2024 10:10:17 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id pj6-20020a170906d78600b00a42ee62b634sm1868382ejb.106.2024.03.15.10.10.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 10:10:17 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so328583466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:10:17 -0700 (PDT)
X-Received: by 2002:a17:906:550:b0:a46:d8:1690 with SMTP id
 k16-20020a170906055000b00a4600d81690mr2346753eja.69.1710522616736; Fri, 15
 Mar 2024 10:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfNFRg-KxTCTPf92@redhat.com>
In-Reply-To: <ZfNFRg-KxTCTPf92@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Mar 2024 10:10:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4qK+zHrrYehidKRp4Fi6e4qUD6Tv6Ed8USxUC+H+HrQ@mail.gmail.com>
Message-ID: <CAHk-=wh4qK+zHrrYehidKRp4Fi6e4qUD6Tv6Ed8USxUC+H+HrQ@mail.gmail.com>
Subject: Re: [GIT PULL] dlm fixes for 6.9
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 11:43, David Teigland <teigland@redhat.com> wrote:
>
> Fix two refcounting bugs from recent changes:
> - misuse of atomic_dec_and_test results in missed ref decrement
> - wrong variable assignment results in another missed ref decrement

I pulled this, and then I unpulled it again.

That code is insane.

This is *NOT* sane or valid code:

+               while (atomic_read(&lkb->lkb_wait_count)) {
+                       if (atomic_dec_and_test(&lkb->lkb_wait_count))
+                               list_del_init(&lkb->lkb_wait_reply);
+
+                       unhold_lkb(lkb);
+               }

the above is completely crazy. That's simply not how atomics work.

What's the point of using a refcount - an atomic one at that - if you
just use it as a counter. That's not a "reference count", that's
literally just broken.

The whole - and *ONLY* - point of a refcount is that you are counting
references. References that *YOU* hold. Not that somebody else is
holding and you are releasing.

If you're the only holder of any counts, don't make them atomic, don't
put them in a data structure. But you're *not* the only holder fo that
refcount here, are you?

Using atomics for this kind of sequence shows some crazy crazy
behavior. It's not valid to say "ok, as long as this atomic is not
zero, let's decrement it and test if it's not zero".

Because for an atomic value to MAKE SENSE IN THE FIRST PLACE, there
could be somebody else that comes in and also possibly decrements it.

And if that happens between the test of "is this zero" and "did I
decrement it to zero", you now had two decrements, and that value is
now negative. So you didn't really have an atomic value, because you
did two operations on it.

And dammit, if that mutex means that it cannot happen, then WHY WAS IT
AN ATOMIC IN THE FIRST PLACE?

IOW, if you have locking that protects the value, then atomic accesses
are STILL wrong.

So there is not a single situation where I can see the above kind of
code ever being valid.

Now, if the issue is that you want to clean up something that is never
getting cleaned up by anybody else, and this is a fatal error, and
you're just trying to fix things up (badly), and you know that this is
all racy but the code is trying to kill a dead data structure, then
you should

 (a) need a damn big comment (bigger than the comment is already)

 (b) should *NOT* pretend to do some stupid "atomic decrement and test" loop

IOW, if what you want to do is get rid of stuck entries and set the
refcount to zero, then doing that would probably be something like

        /* This is broken, but.. */
        stale = atomic_xchg((&lkb->lkb_wait_count, 0);
        if (stale) {
                list_del_init(&lkb->lkb_wait_reply);
                do { unhold_lkb(lkb); } while (--stale);
        }

and it needs a much bigger comment than that "This is broken".

(And I don't know if you want that list_del_init() before or after the
'unhold N times' loop).

The above is still completely broken, but at least it doesn't do some
kind of odd non-atomic test and decrement stuff in a loop, and
hopefully makes it clear that we're very much talking about fixing up
stale final values

And no, I didn't look at the code around it. Because I really think
that "while (atomic_read(...)" loop cannot POSSIBLY be correct,
regardless of any context.

                Linus

