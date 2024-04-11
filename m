Return-Path: <linux-kernel+bounces-140761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422658A18C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B0E1C21569
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D45C1CFB6;
	Thu, 11 Apr 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wm8hg58f"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADAB17C66
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849499; cv=none; b=lGsCoQB267JznzTsgP7UoK96/+gp3Cmo8IUfuv6KJc/Db0A3YFm07K54E6pLXvrZmn2w0cyUGaGmAQL+m14GLuk8Vtmjhc/JeIQLISW6C0m0BI3Ljew1puQLt1es/PDJlEBU8FR01uwPlXhAAYQAirqWveu+SGJvn23WFcKc3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849499; c=relaxed/simple;
	bh=sMDFBW3zRYhbJtL4VOoVGjo1NEw38bdXVkujq/zHJqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epTV3mRUTcWklZOMPUUbGIDFfVkxMVwP4MlexCe7B1Ff9RDpCuepXmZdbHhfuvwnHlbg21Kdy0Shi6+USdBbDkxzgBavcwPgIP17Lhsw3bKFF1TM/Ipj3bQFw2zKwmJ3GHVHlrhzxfUUWxQUf0ITmz0TPTZdlG5AAPqytTe0Z1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wm8hg58f; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a1c0bf9faso4607835ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849497; x=1713454297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcJKg3dUprDfAl9aQ3Nn+s/bQ9YKDokhdxZS/KpvLRk=;
        b=wm8hg58fZ2nebOuKTQkzBLx1nZ8uF2X26x97QNPDltHHbOaskPguYBtOPHXX0l3Ac8
         3hEFzXRkIh6FBBfNTLg/8sEQpshr25YDiQgFpB0Mq7Nk8gH8C6/c/Whrm2snsh2/1ZeZ
         re/yXuWfhP9lbmMMdUjLTg2WusZASUqv8LRNiJq5K0/ElMFQzoGEIcU4AKrgL1cztwEK
         cufquyFBsf5MxAaoXGZ9FZS0BMpjWUt9qmfCT3j9tSGsam++rj63jSCr9MrR60V0nqKy
         +XJvoxUJTvWtxE7Mla0lL37qg3hmZOm7Mml6qYmvmLjmaMzM0YAH3IU21TUr1S6hsH/j
         dqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849497; x=1713454297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcJKg3dUprDfAl9aQ3Nn+s/bQ9YKDokhdxZS/KpvLRk=;
        b=WcSbJlw7IeRXJQdLscQMhj7phnbAQut1lJl7y8gZP2qnu+LVpkZv1yRDDQL0LbJv+u
         YYDbzWfcWiz+W0ZVzPr+jiwh3z577wTDUIzehWPDJ94lGYBV56Tb6BUltjE0D52y0TGY
         iFSUNZj0chwWqr4wODkfJ/QGtVLyOalbt3QHDqNHKkPNdt9Db5lJ2jKqvNbCk3m5aRCN
         hAQ+68A50U47IUvej+N/Vzea0amfVqFUkIL0+4UKOHqNe/C+CDLF6V2Emx/3uvIEtNj4
         QxNlIHR/gohIW3K+HhRgIEjd5Lrq2QVmCDR/H3d+f3MdmBBQTlSQENJeTh5IXiDLXSgw
         kLhw==
X-Gm-Message-State: AOJu0YyIAZmEz2lNkoW6jePWd8HBQy/8WkIPsWATbPBpfXeYEIH1RE9i
	Gb9e5MTyMCxfDB//rqgX1aIzakvDopw2/o2hUqtEuMolN3C58aPDMm3sO//mjERzcKaJJZHshzt
	c
X-Google-Smtp-Source: AGHT+IFmv7WX/xf4bBGpnBWshwlKmNSTByFuNkK/HLYUxfdD+WtzdBBNpSKh8VfIJUDZICKWjreOuQ==
X-Received: by 2002:a92:b10d:0:b0:36a:3ee8:b9f0 with SMTP id t13-20020a92b10d000000b0036a3ee8b9f0mr4225572ilh.0.1712849496832;
        Thu, 11 Apr 2024 08:31:36 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 005/437] uio: add get/put_iter helpers
Date: Thu, 11 Apr 2024 09:12:25 -0600
Message-ID: <20240411153126.16201-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For users that currently do put_user(val, uaddr) or get_user(val, uaddr),
add iterator versions that do the same thing.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 7020adedfa08..ed1711201597 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -215,6 +215,9 @@ bool copy_to_iter_full(const void *addr, size_t bytes, struct iov_iter *i)
 	return false;
 }
 
+#define put_iter(val, to)	!copy_to_iter_full(&(val), sizeof((val)), to)
+#define get_iter(val, from)	!copy_from_iter_full(&(val), sizeof((val)), from)
+
 static __always_inline __must_check
 bool copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 {
-- 
2.43.0


