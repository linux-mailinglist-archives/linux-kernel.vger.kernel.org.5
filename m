Return-Path: <linux-kernel+bounces-138483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D0189F1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F901F229AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090EE15D5AF;
	Wed, 10 Apr 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U/dTef3t"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCBA15B142
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751883; cv=none; b=XIiBRuH9SplOOzppOG65hjAOe5K6BDh6yjV5Ee8EiAlhyMPFAgMvy24hhle19dYeYziPMegBsTvGkCGEcsNoOx30cj6WbYZa06KXJh3I634Lz86E/k2BKADGYmgDB1i8rfc1PhgjaaxOWp4Xj3MdvHw2WrqFkGqFpDjnJqXD7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751883; c=relaxed/simple;
	bh=h+vf7G0kjHJYwkBBJVmcfH0e9L0dP7Y8XHI5/w0p8E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YwQ3LwXATCwWFlaTiuSoDL7vRD/6P0t14rGi+i4NE98tWXnPLdleoCfk0TqWxirxQj2q91cJVX7AQFKFte+Oz4Vceuj0dbCBKs77jpK0UDiBBbeZzzZF+aVx+B+v2mbAYW/79tYCh/rhzk/8C0eGXV4grgqW6+NjalZIQxXaH2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U/dTef3t; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78d5b1a34fdso272201385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712751880; x=1713356680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cipJ+LzpYmxWDcZVVR8wW5ciiJUlfL1kO9izAQg8a5s=;
        b=U/dTef3taUbXkewVMCfH2+D+7zsCLSxLU1Q1Ok6MWaBeKmrGmViTlZ/40S/jkw/K8C
         3XsYzUX0VWfBRZfJY32wEoOB3AO/Y5uqXTo83LZ0thxQUGcpvHad0zUYpKt/mt/sz+Wr
         H4JbalpY5SuY/mAx12oKhO8uXzejllEI1Sn+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712751880; x=1713356680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cipJ+LzpYmxWDcZVVR8wW5ciiJUlfL1kO9izAQg8a5s=;
        b=iFrcN6LJ1SFHI21mlpRuZDqEvlueGRNCW/Ddq7GjgOn+5K7cc/x8k2+wVsG0cd8EWU
         vRvrF4HPRHEp3uUlP1e0Da+Xf8OWBoRrAf29Tdpk6JwaPCNflHS2VXMLKb2qs/gyrMW7
         xBZTB721yy7dpL9HDbabX7sYkNOTOvyrywbjg+Pnwml3wOEsY9Myjwnzn6KSGr6iz5Q7
         nu3n4Vf53QfvT1vKKO2TliFLcRixCecAv+XtTjvfYHthYW+bEnX1p5z94ijX4ajmDQ7c
         DLskqF55er0MrFvPWxgsIcqZO05hZykneKK2E6yWbwM2zLM+SY9wqd4uVsS/5qJvHdzL
         GZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfDZjPWvoUV9xc1O1whz0LrOu5oeVQ5KI5iSYIt4lS8uNb09T+nFSc6mztiuhEBT2oi/IloCZ+4DVqrG0qmIRkzc3qJ9XMliSVMBuX
X-Gm-Message-State: AOJu0YxuC9ZsZFSY9TTN58V5emPx6/GiH5g1sOu16o3pZ0RBVn6Tutt5
	sPgOP3jTfsb8I/uohlFy9EedHiLjCRqIFNuc/6VGuwLu5Loldho2vK7sSlOFQNH4SCTuiVmAwFW
	G4Q==
X-Google-Smtp-Source: AGHT+IEymOH/PliO0PmHpGlN2VUrtSmnhFU2/z8OBzR7B82zy/tWDCDTqVf5tJGOnAn4PsawMwbbnw==
X-Received: by 2002:ac8:5a0a:0:b0:436:4da4:7801 with SMTP id n10-20020ac85a0a000000b004364da47801mr204451qta.41.1712751880710;
        Wed, 10 Apr 2024 05:24:40 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id jy14-20020a05622a818e00b00434ce53c664sm1921579qtb.80.2024.04.10.05.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:24:40 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 10 Apr 2024 12:24:38 +0000
Subject: [PATCH 2/3] media: dvb: Fix dtvs_stats packing.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-pack-v1-2-70f287dd8a66@chromium.org>
References: <20240410-pack-v1-0-70f287dd8a66@chromium.org>
In-Reply-To: <20240410-pack-v1-0-70f287dd8a66@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

The structure is packed, which requires that all its fields need to be
also packed.

/include/uapi/linux/dvb/frontend.h:854:2: warning: field  within 'struct dtv_stats' is less aligned than 'union dtv_stats::(anonymous at ./include/uapi/linux/dvb/frontend.h:854:2)' and is usually due to 'struct dtv_stats' being packed, which can lead to unaligned accesses [-Wunaligned-access]

Explicitly set the inner union as packed.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/uapi/linux/dvb/frontend.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/dvb/frontend.h b/include/uapi/linux/dvb/frontend.h
index 7e0983b987c2d..8d38c6befda8d 100644
--- a/include/uapi/linux/dvb/frontend.h
+++ b/include/uapi/linux/dvb/frontend.h
@@ -854,7 +854,7 @@ struct dtv_stats {
 	union {
 		__u64 uvalue;	/* for counters and relative scales */
 		__s64 svalue;	/* for 0.001 dB measures */
-	};
+	}  __attribute__ ((packed));
 } __attribute__ ((packed));
 
 

-- 
2.44.0.478.gd926399ef9-goog


