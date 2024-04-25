Return-Path: <linux-kernel+bounces-159290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C688B2CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA0D1F28A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54AE15E7E9;
	Thu, 25 Apr 2024 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oJ5XjVHB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37A156223
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082335; cv=none; b=G7OfBxu+sy+OWXIDLJXH37iZC3Sx1jCWzfDCxaDU8DdA9poke5o7ljMnCtr6SeVfubabMt2Qb/+l/oBmCNKtXjpJZSrB3k3jfCxQbadu1h1YNpC3aLvULprSeFKRaGaImevdl79uSC3y05e8+YCYh1K3NFYTkMUnD6m5ATUNRWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082335; c=relaxed/simple;
	bh=h9WGtGVSwWrsCyL4fa5pUTm2x1e6K+XNP8TVlAlh9sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkJbADMSVBN9NctX67xK6Sz6Cd6/kYnCesc25HtnDACX3BHPs9/a/oNA5vyPxFy3o18njYsY+r/RAzCdk0banCatgA+MBaDaKNAPq3wE8rEZ608o5DZQr5Xw7CbkIUJ54YP8rY3TgR0OavjEmGNxjZ88NjCmOHKODQIJaZBc81M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oJ5XjVHB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1eab16dcfd8so11671175ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714082333; x=1714687133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyKXqHXdhexBTnprpfz03So0iJGmYp1QrUkCgj2t6No=;
        b=oJ5XjVHBylrAWI01KbxfC8BsPMly7CdIMdGP5f9i6whN3OyhSvtphwD5tGjOC+ZfMj
         gH+NK4jz6y9HkdvRYS81XePhMfHWX3ds3IjEZfR30eiZe7eia88M49WpnOTCEKS8TVH8
         hXWjxNmGRt50joqEayCExELQL1aXoBFU7G/Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082333; x=1714687133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyKXqHXdhexBTnprpfz03So0iJGmYp1QrUkCgj2t6No=;
        b=E8oumCPT3FLQArHX7bkyJSAZz2bqe2MI1oZEeO0lW344VFAhggpv69j8pqaAoIOExm
         QsAizbJSWMxmtnjbbhAtsSwozOKHuwSkO4JvnYV2g3FUyXfI/qAcy43RbY5VsiSQepjD
         W5Jzv7mhkWo/CO5l+IQ2Xdfbhb2zkZbKqRINua7efBCZ5f+dU7by4yhra65NQ+XIqjZ5
         NXLNGa+pcFzYs4/sjX89xog3MLXuY6j1WMEDEK7Sy1AgnYY7xk6I85fbzykesPizpZOX
         S6rSCWi8Xng5DJ1ZThVlteCUeaiD5/I8g/WXoqdKDXmZ8EJBqA6Ze+x5oWDKNoR33+5q
         11Rw==
X-Forwarded-Encrypted: i=1; AJvYcCV6s3uwGLuYRVfQ5E+UHCvVFmH4n+C2Emzfdum/d58F+sO1LPxArXDmhu+XyiL6mwmEzZOT7u8LnQQkQP4v/am+8WCu67XPDrl1mnMQ
X-Gm-Message-State: AOJu0Yz1lWmMGr+UflxdcgSWiVy2AYx/DSfGp/zv8LkN86z8RGzpW7VY
	z4tEQy+lHW7kZLWA5Yr0+/Obppc2YVxeVjqRu79q704zk7Y/zKkameolxBTGGQ==
X-Google-Smtp-Source: AGHT+IH/cxWENQqM4AYQ883OVrqAX84qQPWXFY3IeDRzC/0u/0+YpURZK7f/PMCC8mVKz9gGpn3XFA==
X-Received: by 2002:a17:902:8f81:b0:1e7:b6f4:971 with SMTP id z1-20020a1709028f8100b001e7b6f40971mr816885plo.27.1714082333016;
        Thu, 25 Apr 2024 14:58:53 -0700 (PDT)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id f8-20020a170902ab8800b001e4a1f40221sm14221025plr.84.2024.04.25.14.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 14:58:52 -0700 (PDT)
From: jeffxu@chromium.org
To: aruna.ramakrishna@oracle.com
Cc: andrew.brownsword@oracle.com,
	dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	matthias.neugschwandtner@oracle.com,
	tglx@linutronix.de,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jannh@google.com,
	sroettger@google.com,
	x86@kernel.org
Subject: Re: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Date: Thu, 25 Apr 2024 21:58:46 +0000
Message-ID: <20240425215846.3276082-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
In-Reply-To: <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
References: <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

>The semantics you've implemented for sigaltstacks are not the only possible 
>ones. In principle, a signal handler with its own stack might want to have 
>its own key(s) enabled. In a way a Linux signal handler is a mini-thread 
>created on the fly, with its own stack and its own attributes. Some thought 
>& analysis should go into which way to go here, and the best path should be 
>chosen. Fixing the SIGSEGV you observed should be a happy side effect of 
>other worthwile improvements.
>
This is exactly right. we wants to use altstack with its own pkey. The pkey
won't be writeable during thread's normal operation, only by signaling
handling itself.

Thanks
-Jeff

>Thanks,
>
>	Ingo
>

