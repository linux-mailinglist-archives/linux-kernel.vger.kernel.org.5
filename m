Return-Path: <linux-kernel+bounces-123709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C06890CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8429A1F2284D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB9913B599;
	Thu, 28 Mar 2024 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HVKRRefZ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9995A13CC77
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663605; cv=none; b=s1WRdKQjDeJ/Ti7ua+/Y3nwmethnj3Uo7/eqNxPQoqzWLFWEgBR17qGxMXqacS1rL7o19k7h40SrT/E/r9AMRuzEpFiAiK2efa6+vXwudxPwJJswgGXMrDqevyc5/LkyaQLgQmRzNa3RbZNVJas1Shg/J8pfo6HOLnMlqggT60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663605; c=relaxed/simple;
	bh=uoxE7PhxoFrPFSaL6qMa4cEt83/6H2mJrsOoFabR0CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3HLc1/xMfOD099iP2p0DWO2+8OLHOkVKyMxXRJSQtYIeAMdP7nU/zw+Uro7+6ep0tfE+TBTrLI31EYumIjC2ZuFbWVs8DMmENViNF0GoXU2O+tzeJ/7qcguRB4RT4UzlsJ/ADgTXJnxB8zfLBZDtci/plNPDrXESxyWYW46jTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HVKRRefZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e034607879so12473685ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711663604; x=1712268404; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6KiZxiesCbvSLPbFTMf3kTBinr8ev0hUdvWiChdToEs=;
        b=HVKRRefZfPSOBroy3yc3vb0+K/40eX4J+0P91V5SZjVq12/7siepkeFYrUDZnmfdOq
         sWJ1zAuKZyQG4LgXnvBU26IUpY9QpxFwgA/8Gv6bSPJrdscHJFzWbHpGJWaiCK/BFbtt
         FgmZFOC418H2xuhq87Qm5YdC2VTR+BxaFEzjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663604; x=1712268404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KiZxiesCbvSLPbFTMf3kTBinr8ev0hUdvWiChdToEs=;
        b=wjv3ln4NgYKDCY6fwmXKqJ57+AmstGVSlV7yzT0ruw8dfa/h2HJjKGQpw/0K4YR+RR
         EHe1LS56OdrxTFTCRnxy2mkJPO2YHI8qjS6A7U9bLgzZNd+f901YpwQG08WXUCqgOtMz
         4qDoTX+38aYFxG1hK5CBEDqO83TofuNCM7YGrVpBwbbCB2tMWPebmFD84Vi8G6KPaaoc
         LNa803MytlRjDyDd4oRxJjh9gj4iZULwPXPdkqHIHNfW9l2nlSnPtK6uFBrXuNu+Njky
         EasLODqLXEkXET0K4ToyOwjIAJmZgFoRmMFTDwU7nIILRvK8o7hVegXMsO9f253XU1Un
         Tadw==
X-Forwarded-Encrypted: i=1; AJvYcCUFB8zHWH2ii2jcDr04nGdKPsKHMEgnuYNvR6VPuYaZp8ivDqnwdmkDYIU2T398CTepOVWHdAkShXrfaSkHBbYbck5v9u+eIehM30Z7
X-Gm-Message-State: AOJu0YxcNI/atWGPmgaH310qNT4BGb80eXi9NH6+Z3WNFcEIi6xsypLT
	9I6nIb0ROazrJY1HItG0z94/Q+y98TjZHqaxo86KJ7az7W160/mdxrkHDaLvYA==
X-Google-Smtp-Source: AGHT+IF0ahQIhXtH0Mm5HvMCxO2IHtnyeHGy61YZR+rY3O0P7+1ImCbuQoPl7zqjcO0b7rQIv2AfXQ==
X-Received: by 2002:a17:903:24c:b0:1e2:573:eef7 with SMTP id j12-20020a170903024c00b001e20573eef7mr1030952plh.0.1711663603977;
        Thu, 28 Mar 2024 15:06:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170903230900b001e14807c7dfsm2142788plh.86.2024.03.28.15.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:06:43 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:06:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] yama: document function parameter
Message-ID: <202403281506.46D9C5BEEA@keescook>
References: <20240315125418.273104-1-cgzones@googlemail.com>
 <20240315125418.273104-2-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315125418.273104-2-cgzones@googlemail.com>

On Fri, Mar 15, 2024 at 01:54:10PM +0100, Christian Göttsche wrote:
> Document the unused function parameter of yama_relation_cleanup() to
> please kernel doc warnings.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

