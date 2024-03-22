Return-Path: <linux-kernel+bounces-111023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0896488670F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FFE284423
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A341610A01;
	Fri, 22 Mar 2024 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+gT6zhb"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9110FA;
	Fri, 22 Mar 2024 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090068; cv=none; b=fCJa3U7thoxtQSMHKchcFWn0KJ0kAfNtfMX7TAhtfRrR0eb1GOV5FyxrPY7IBaiHzr0ezhvRDaCwkEUvYLmw/1u5z3QFzr2UuYKvPJhfqknvkH3rcEH45Y0cD3Cnd1VOZxU8cih0goY9ee14+cicZ6fiVmqLhMSOaRClZ7ifzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090068; c=relaxed/simple;
	bh=o6jZmD1miWV/FjVIa3UKpDCb81d3rX+z6soNykf2YYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnCKgseWVnl7RXSs3fcGf2HYMmBfYMVZVJVkQeHARWAjPBXC9jb8oqJM0w/hQtP1OCIqy7g8XjeieHW7pxg+naKecrAr3QT0bz5rF0lwMBbplN7iwdbV/pOm2VTQE5tUyEZp2dKEGdBylU677B1bYFz/0elsekHYMHKjUsX/A0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+gT6zhb; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29c5f8bc830so1209037a91.2;
        Thu, 21 Mar 2024 23:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711090066; x=1711694866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6jZmD1miWV/FjVIa3UKpDCb81d3rX+z6soNykf2YYA=;
        b=G+gT6zhbz6hMVwQP4fPck0rcuexrXZwS1G/9C+gfgy93w2d8u/mQK7nJ93/8+qtA6u
         KBvIBN68z1Lw0W5KNvlEuhyeULOlEntFfkJO2fBHz/WXGUVODF+HLHcab16NXc8Z5DIe
         SRhGZhUIOTQMwqvwsBY16Zi5x71biDtIVxOOF+Mbw0s5GEpAQlYF1+tAZeY7lux2obAb
         ScvHvYvUvz1x0jT+T+f0+nvalcXdj/5Y+dV6F3ldbgRsVBZp3djLdyyVkEXXciRcr8jr
         D++d1Q7rl4vnP8C1uPfb8DYrQ6vLzKehMG4GD+iSKaNCMcqnx/Ue9JRUa4vK17zr3W8L
         /B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711090066; x=1711694866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6jZmD1miWV/FjVIa3UKpDCb81d3rX+z6soNykf2YYA=;
        b=bKMzpimCvuHLz2Rb894y+260+kjgbWTqfuKbRSDA7AfHBVij9Fn9O4odgkhWecidxu
         mHW//qkM54ttfGsvRctqd/5JE290K202Kh4mbSmXGpNxhzZov2nO2/0UNR3tPMqnqg2/
         g24Hpomh8kI7M66DtMRcI2S70Ywl6/Ad3IaTCkXXn+YHB0txjf0o248hpAFiXxuiGbmP
         VZNblVuk4DBWrhr1Jn/fxg3uapNH350vtNsl7DQ5cSqQD7MfAO9hBs07g3AIejKW3kbA
         XPdHXWMBYwQpp65i4IhLlH/wzJSr8KEJGGr/1hzbo+KOzaClW9QqMd3h8WSCmi83tMhD
         s3wQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+1TRizCPfKtOn+PFXdblhM4KhnKDtAnW+nJYpE4HWIXJVVajapD6bjG6I6+/lMlSqn9fCwCZ136NuCEdwMTZGIVvvSByxD6ub5UASffvjSnt2veM3sku1TOh8Bqx1DnOezKeG1Jie61PzwlDTWdi9LiqJoBS7xNehRbOrrUfXKxdCzlPU
X-Gm-Message-State: AOJu0YzEl/hT2LH0c8aYWZTSsmpfk+p5aI+N8zCwJ3lGK5lIWzI2OTto
	w51BB5UaQklt6Bbk4Yh1DlPDP0r/kyWMt+/Cp6jLukNfesoqykK0
X-Google-Smtp-Source: AGHT+IFc20qWQlBrqoDBDCNLhC24Jv7xPMgOQ4yQW9HjN7hAJhy6Gxj1UnPJWEjtLiBZyq7OT3qfBQ==
X-Received: by 2002:a17:90b:374e:b0:2a0:3d04:8513 with SMTP id ne14-20020a17090b374e00b002a03d048513mr479713pjb.43.1711090065919;
        Thu, 21 Mar 2024 23:47:45 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id ok12-20020a17090b1d4c00b0029df82469f4sm1117805pjb.15.2024.03.21.23.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:47:45 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: liujianfeng1994@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	ezequiel@vanguardiasur.com.ar,
	heiko@sntech.de,
	jacob-chen@iotwrt.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	mchehab@kernel.org,
	robh@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH v1 2/2] arm64: dts: rockchip: Add RGA2 support to rk3588
Date: Fri, 22 Mar 2024 14:47:34 +0800
Message-Id: <20240322064734.3509132-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322052915.3507937-3-liujianfeng1994@gmail.com>
References: <20240322052915.3507937-3-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This node is not sorted by bus-address, and anthoer patch adding hantro g1
with addreess fdb50000 is not merged. I will send v2 after that patch is
merged.

Jianfeng

