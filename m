Return-Path: <linux-kernel+bounces-159295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A08068B2CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63285B27FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95F171679;
	Thu, 25 Apr 2024 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mJvzAyPr"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986014A0A7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082616; cv=none; b=KDS7a7CPlurDESNL78+K9MAsd6ne6c3iZsLT7M5lzjKNv8y++lyvsvzfcB0QBywd+FzfGMXeT2/HOV0FQh4rsdjB/sN3l8NF0RYnBaNArhbpdAkZb6NQhpOZnUxGOAhnxLILOLLyxVbHINHhu2J9ez20PieDP0P3iESUsPareF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082616; c=relaxed/simple;
	bh=L4HyJHm2zmRW8kG0EAfkWOdZb0hKun9yEy1bDfqB/kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkCiToqZcJMDtFcCE9Z84mXTj43/ZWvaP3hRhep8G97Q9koRrYKAt1BTk8mUz5/ueP4U22TsVV+nXqPZBCxveiEQqGSnMJJQpQKp7/ogHDlz4hNA8NsrLFCMAoe+pVS7/RHwl5wCdmfhELXFVrGmQf0rBfo5K26EsH9UH9/Q3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mJvzAyPr; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a564ca6f67so1362939a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714082614; x=1714687414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPif3mAhk2mjxY5/ADz9MWVNfAUOyxoP0nyi2kzmfeM=;
        b=mJvzAyPrhtth2hq/O3F4I9vVcRpHB0vPAmq9nrkcMc1ACIN2jKsvKtWxr4BYNjeB9O
         HlaRbxKPGmv4IofjcryV8Npzcoso0t1UCdySSSf5BwXOEGfCNo2PqyUClQ2R1RbjODxe
         MhjXOE7OXBeyIIepQSuWLnCspCSXzPOdV1aoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082614; x=1714687414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPif3mAhk2mjxY5/ADz9MWVNfAUOyxoP0nyi2kzmfeM=;
        b=egx3PZaAa3FijzpAgXOcdt3/MMU7QAUeKTl1Zi9EtwWu5A/93IfQrGSz74z4CxpmcS
         FJGQ/+L71M3fpG8oSOdD7Ozcr3mwFTOoRzUgL3o1+6lOdgUS8DmJBTYnSTtJEgoTkjth
         9NFPgr5xmnEqws+nZKZ2E8b/+G1oyFB3+nBmokfzdp3wUdSx0J01ERLNEOeae5PPxJGC
         EtKASGN9rbXDLb24Oaj6IsfwbiNP8m//kL1FTCfzYXD6k8Mj1vHud8nbreDg5Klf9AnX
         DDYLgr13VPoTN5FWXXlwi3GbNqXQXPbBQyiKADgmZWr62NC0iseCUoDPbzdbKR+0gua+
         MbjA==
X-Forwarded-Encrypted: i=1; AJvYcCWtF+aezpd0AzoQUTfAxZK25PVjRvCJdReUEyLswl3Bvim/p4vG3QOIqNxTR/XLbftmsGlbRQwSiZOD6pzoXqeyKKAbV77Uj2hrvTF2
X-Gm-Message-State: AOJu0YxSM5yQt5guhAyM4Cpfcf6+LoDFP3NRwkEk1rsTgUHqoS+fo6Kg
	gyOODeFveAFRUBD38rvQ/aKEYwbNmB1h56rQLQ67gJ8ueX7X58T3xLpGZmvMXAWSikhAR0NqbJc
	=
X-Google-Smtp-Source: AGHT+IFasn/A+C3DUXeoAtwokegR3Wxvx2HwuaeZtpJ1eb4HcTbF2NtMz/V8UMWj1qVZcQ9FHM/P+A==
X-Received: by 2002:a17:90a:eb03:b0:2a2:ba9:ba61 with SMTP id j3-20020a17090aeb0300b002a20ba9ba61mr1066092pjz.34.1714082614686;
        Thu, 25 Apr 2024 15:03:34 -0700 (PDT)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id l8-20020a170903244800b001ea9580e6a0sm2574036pls.20.2024.04.25.15.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 15:03:34 -0700 (PDT)
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
Date: Thu, 25 Apr 2024 22:03:32 +0000
Message-ID: <20240425220332.3277193-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
In-Reply-To: <Zf1TX3QXjWQsVp2R@gmail.com>
References: <Zf1TX3QXjWQsVp2R@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Resend(previous email sent to the wrong thread)

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

