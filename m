Return-Path: <linux-kernel+bounces-10111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FB81D05D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177551F225D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9243233CEA;
	Fri, 22 Dec 2023 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="chNSw9k3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84620381BE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67f3f602bd5so13998726d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1703287029; x=1703891829; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7CpW3HQ3edIB3pC1X9J+ZszFBlQ3pCTa21G/iZStcgk=;
        b=chNSw9k3tyBBgPYw368jZIK4B/DunMkafbHBcScFFElE9LbZVaHnoY6/WC1411wKc1
         qKENLCvlnT6EwlBVRhes/VZczfvM++sNQqp4b3Bzi/Y7+XVEEPBdcLOqaN0RqovkQQtC
         iniERB8qCeQ3xG+6mVjD2hF/2CE5XWsSPWA0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703287029; x=1703891829;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CpW3HQ3edIB3pC1X9J+ZszFBlQ3pCTa21G/iZStcgk=;
        b=UwrikfGSptgD9aZMLRTmhuE2zQ+/bJgLmdR9r4aM6yb8HT3SV46i8Cf4wTFDK8p9xb
         aABeN3mBco5SZWy2NeGmw7g9rZ/egkXm2avv1eTxQoVcUasZt7jrJloT5I5Hr+a5koVd
         lycjhdUEGi3DlPpKftbM28+Gtr9vbTe8dE7WaGphfg+ba31zfIhRF548G10al7WY1o83
         +VE5rV08zyo9yJ5N/y29+vtLdYQpW+V+ctQ3p1EtvyhitlhwmKNDkat7w9coWIPw4iY5
         7+fS0OBxMtCIhpMo8MxYnwVuPo8AHzh2JsGOlbvylaBaB7b1HOXbhec6uh9Y1qTvAzzm
         CB2g==
X-Gm-Message-State: AOJu0YzeUe19+utmaLNZ+05KvLE4s20zqE/ZKGCnMIM6gSRob8fVToRx
	dia+LC5Bl7mMD3AFZPpvnFnEuRd5JvfzLg==
X-Google-Smtp-Source: AGHT+IHS2SZicxvBAydDZ0dczVgPVcMjllDPAaqVKpGvtypPcvbU5dRrD+q0Cevn+jgytzUmjAUkXw==
X-Received: by 2002:ad4:5dc6:0:b0:67f:43ef:c8df with SMTP id m6-20020ad45dc6000000b0067f43efc8dfmr2476193qvh.98.1703287029358;
        Fri, 22 Dec 2023 15:17:09 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id gc7-20020a05622a59c700b004260c76e4eesm2221739qtb.27.2023.12.22.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 15:17:08 -0800 (PST)
From: Ivor Wanders <ivor@iwanders.net>
To: linux@roeck-us.net
Cc: corbet@lwn.net,
	ivor@iwanders.net,
	jdelvare@suse.com,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luzmaximilian@gmail.com
Subject: Re: [PATCH 0/1] clarify intent of fan min and max attributes
Date: Fri, 22 Dec 2023 18:17:05 -0500
Message-Id: <20231222231705.4338-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ce60c838-0fad-4bb4-8af4-a94d43092d4d@roeck-us.net>
References: <ce60c838-0fad-4bb4-8af4-a94d43092d4d@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> I do not see the point of clarifying this for individual attributes,
> especially since that might create the impression that it would possibly
> not apply to other attributes (for those not reading the above
> documentation).

Okay, fair point, I can see that lead to more confusion indeed.

~Ivor

