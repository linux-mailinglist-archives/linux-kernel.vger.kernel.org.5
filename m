Return-Path: <linux-kernel+bounces-152379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F78ABD94
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 00:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 464B2B20E79
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 22:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDAE482CA;
	Sat, 20 Apr 2024 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8fepuEs"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA32747D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713653034; cv=none; b=A3bnVml/5U3gNXdEsEYaUlGlEi6/8Nd2erK2xEoEmv9cNw2T3dSpXDTWO2zzO9XbR30KCf9RNPEBpzrw2y+/mey/u8slfxHlKFK9xoRM3YvGBEoG7dRkI7gSjgrqV+KrQBsNUYy9cAghXVL913Z+OQlG+uerrXpmwC1iLgY78iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713653034; c=relaxed/simple;
	bh=7fN1X7AuEKLSn7BDMUoq8jVpAE3NIIja69/AWX9iGyk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:In-Reply-To:
	 From:Content-Type; b=HhKxStqgcTSE1pjHTwHf9vmPUpgYQOhzdQPyBrzV5RWnGMbVPu6TEV8j3lMwpaxMSJUMeG5cSM2aQ/1M8fSx3W7Wt9E5ZLvn4G5BbeeOXCECtF0d/f0ZR0OnaYzwgV1f6TfmNSgQbvKyCLuu9R4tUFUsYLs35CVaVCNMlH6f7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8fepuEs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-345522f7c32so1387860f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713653031; x=1714257831; darn=vger.kernel.org;
        h=content-transfer-encoding:from:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3edFACX8jpQENcMXve7N03WoFbIGtGdsGvAUD7lFqSM=;
        b=g8fepuEs4tSLLrxgFvjc7s4XDZGB2fYEZgVb4BFSFBrGz8VpM7QpXYBbJwR4O/PWbP
         9dlebHQw+4Pq9Je9PMl1qghAGcfLjtd5d6J1Fo3gHFwy01MOCH+C21WmmbJ7gFiIc0hS
         amsqIKMRWee2924ntdBqVCIwALVMqSQh1/VagILdq5aDNHz0z8Z+sx8pYIGFxhTc3HPE
         wLBc0vSXrPNLK9SYEI6Bow45HLLDsE3PIwuFBucuuublyMAP8fhpcmbiyJvIvsf1mMHl
         x+uoz25IFdSjtzaAXXMZCSDQP2LRCfjVzppp0zOJJH95hHyQzfxZOA9SNnCJcVi9dLWq
         smOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713653031; x=1714257831;
        h=content-transfer-encoding:from:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3edFACX8jpQENcMXve7N03WoFbIGtGdsGvAUD7lFqSM=;
        b=eSHzmmWMbGgP/Whucj4QUFg69iLwHO+KLi92aHZ8wDIHUClgR2ozYm5f5Q06k+goHH
         5QrzYsM/QFLpEpPzQR5rbFTTW0MAcOZGM0JhcLvIGmN7kew/IeyUW/2DiV3x3JUKyuPa
         ntljPsZSAs/JILrJwrPsDTCriT3O7HKrPMaHiA3LxOOGydMi/QHk7kSlox9Ki0FbETGA
         gyN9lO15hbto/3dPRdXTFeED12FSQKp+W72NbIToIIypR7bkJ71YhtYqVF8IVez97HCF
         cLck4x0gLgjq1+48elgDK+HRVAiAAkJ3akmUIR0GX/arzWwUEH4jJCMKDv9zqR8gOHSd
         6rsw==
X-Forwarded-Encrypted: i=1; AJvYcCUor+jTU9INNfv8tZu6sBMLOvigg9NT4jJYVzuEnEEieih8F0pT+nUVhx8u1oBk1OrCVkDdg/CqLoTndlZXM2zRl4at4GAQ8bQsFSkw
X-Gm-Message-State: AOJu0YzN/PfXjSvN8aZSoyxhRYRvf+utZgTkJkdsSLFsrJTj9+hcHqki
	84MLGz2gOQW9UhbGhkQXBehs7DUvx8fxk4/6QU6jQG0W8/WfTiJ1
X-Google-Smtp-Source: AGHT+IHE7/rCq/X5hVCefVBXrMqWhBdst02KYftb+ckqD6x+63cTXsdTvW+6x/Mziw9kSdQhEC5kSA==
X-Received: by 2002:a5d:59a8:0:b0:343:7b6b:dcc6 with SMTP id p8-20020a5d59a8000000b003437b6bdcc6mr5259365wrr.30.1713653031029;
        Sat, 20 Apr 2024 15:43:51 -0700 (PDT)
Received: from [172.16.0.2] ([104.28.195.139])
        by smtp.gmail.com with ESMTPSA id s25-20020adfa299000000b0034a5c595a50sm4979162wra.48.2024.04.20.15.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 15:43:50 -0700 (PDT)
Message-ID: <d8b36823-4247-49d4-8de5-d06ea5d85e80@gmail.com>
Date: Sun, 21 Apr 2024 00:43:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: irogers@google.com
Cc: acme@kernel.org, andrii@kernel.org, eranian@google.com, jolsa@kernel.org,
 jpoimboe@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 masahiroy@kernel.org, namhyung@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, nicolas@fjasle.eu, peterz@infradead.org,
 trix@redhat.com
References: <20230126190606.40739-4-irogers@google.com>
Subject: Re: [PATCH v4 3/3] objtool: Alter how HOSTCC is forced
Content-Language: en-US
In-Reply-To: <20230126190606.40739-4-irogers@google.com>
From: Tan Nayir <tannayir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Could this patch be backported to LTS branches? Entire build fails if 
KBUILD_HOSTCFLAGS has flags that would make the libsubcmd incompatible 
with the built objtool, since those flags were not passed to libsubcmd 
before this patch.

One example is that the AOSP GKI builds fail since they set a custom 
sysroot using that variable. For the Google devs, issue b/335829879 is 
relevant.

