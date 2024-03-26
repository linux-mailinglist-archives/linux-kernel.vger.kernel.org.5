Return-Path: <linux-kernel+bounces-119345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D706C88C758
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9236132015D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0715E13CC48;
	Tue, 26 Mar 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZxQ6upFq"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3413CA98
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467252; cv=none; b=uumF03OC0DH5uS3JBaxhH0IDhqUMsgOqRxMMkquTDchimI4pQVkJDXCiarMdNgGoloyyllRq+BKzfAPnc36HjwgTQLNsnKYTjG8zx8DJauCRC65HACTgBSLMNF1XUsSe+L6Ba7H2HUvLttcopUtkc5KNlZCkei35otuMiaztc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467252; c=relaxed/simple;
	bh=YCGVUXqjT2VDQHJCmUVjnpWe1+Wa5WfZ7bt5vQxRrH0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lVVTn4hSe07YiTpEjnzYaZ9vKoTcZPdVHF7q1hOyjuSpAKvTVRzXODxUdHMYUx6m7JXctuKhzsaIjPBmnvcNI58nGk065R/jjCOb4RU14s9IDfGeTlcHzgG6Tsc4/mpCYkStwzNlFg0MAqouKkQUKxuuu2+c3RdZP4uJZvabYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZxQ6upFq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c3689ad2cso224779a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711467248; x=1712072048; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55ZfJBrH48piI0JAMfMBwXalNWWcs1zncHAc7+A3Aj8=;
        b=ZxQ6upFqtggDHAVQtP4wSqwXrCR0kCHeJQuCf8XIZ54TueUQyGLos45QdYWFbqiuq+
         YVkUtdqkV/176QcHwmOeET2UQUmSxMNdncaZZLbpkWwnJKGNdBJUsAhbfo1xXzcbyicm
         bnggb/gxgaOWNqH//TJ7Myof2GKzcNlwqRGsztPFn66yTXjjuwiKRDfT2Scvr6lZVatc
         se4FZSE56yjVcraNpqKjGd8mFcSwWOIWmN+UGcDx/H6WhvhSEJSP59mIqKHhUBMCM1+h
         F7rmSWyy6BrBuRwwrT2NpJjCXfdqis9vofpF7cKNMzIdREdF2YSfcNeybFMnhCRSOqPB
         SPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711467248; x=1712072048;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55ZfJBrH48piI0JAMfMBwXalNWWcs1zncHAc7+A3Aj8=;
        b=dvy/FH6An4OfF2K9xXftTBux2CPFqFDlAHHL2Odh+YunaCEgtNgV3ImhKS2y8uc2UG
         EpviELQVoiuJe1RLqCOktcWhdpBrArEsOMxG2oMIOWoZZjv48YW+apGGSKE0HL96XdD6
         fPsYCRHVGZHmo6T9CiwEQ0mPisUGBaS29XWnYuydJ0SfjoDC/e3bBRGskGo3jpXNgLfL
         cLkx9gPD0IKlHQ9i+zTPisTRYi25su+9eXH8pmALsni1iSxNzleAnXzPZgSDnmwKYqPi
         Zr2VrIV1e1VNGW8+IOgBaG/6245fx+xE1nufqk01+lsUl9u6wW6FqxejvuUtXoaToKl6
         PUIw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Z+ZEMk2FRmuMSasAFhu68miavPG9CvANfHDmds6iR6Wb45VGui8HpBGV6qB2i6VaONFZE2LT7rOme70HKqnLPfZBdMSx4FDoY8bN
X-Gm-Message-State: AOJu0Yw+uxOdrRXmUH8lfx0IuZfh87aZIUtDMvacDtM3WOEZuCa97peL
	i5MumGd28dkl34G/n03oF8kwyfbPbkU+Dn9rYGvdtyvkameAcicCPEpgvejFkBY=
X-Google-Smtp-Source: AGHT+IFD72eddjYWygJrpo+ZwRbM4G2apEunAbhdV30JZ5/9l+iXN1FpY93mApNWes/wJ+lV+zL35w==
X-Received: by 2002:a50:d71e:0:b0:56c:d47:e403 with SMTP id t30-20020a50d71e000000b0056c0d47e403mr2263091edi.28.1711467248382;
        Tue, 26 Mar 2024 08:34:08 -0700 (PDT)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7de9a000000b0056c08268768sm3068196edv.10.2024.03.26.08.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:34:08 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:34:06 +0100
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 6.9-rc2
Message-ID: <ZgLq7uQzrzY1_C6M@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull one simple printk fixup from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.9-rc2

======================================

- Prevent scheduling in an atomic context when printk() takes over
  the console flushing duty.

----------------------------------------------------------------
John Ogness (1):
      printk: Update @console_may_schedule in console_trylock_spinning()

 kernel/printk/printk.c | 6 ++++++
 1 file changed, 6 insertions(+)

