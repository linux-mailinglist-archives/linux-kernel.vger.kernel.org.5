Return-Path: <linux-kernel+bounces-85698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B24786B979
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB36F1C2735D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A9586257;
	Wed, 28 Feb 2024 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZTmg2rr"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DC86245
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153688; cv=none; b=hwAJwTjjuSEYZY4jhbdyaGC+k0dDflIV9jASKMirnRJNDTmTtiNpgFq6kn57Ui8Ew6gIF+4tEmzkmuRS3UJgjPCQ+a68W/42Q+kQOB3Hql/N7ky8V8wVA06PHJwBeei4lcLbDBp8xwvlg/YLN7B71M4RpXHW7pXs4ihrqmBv9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153688; c=relaxed/simple;
	bh=lzfXTZX9BZm0o6MiEqD1Uju9dODam46W/LA/7i7rJIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACVi794NXzaWOx7X4Ncn64/EVFLsCaifeoPpDVWJdL41dIeSe1HO/1ZxyQeluT12qpjhgtG0RWjCrLUjpb5QwhZstcUo2B4dFShNSXC6qbX4u26kBpmC05/NZ8Z0tIGXZDuI7Gi/yl66TEXJQ/pTNARkd5Zb50dHE4JNqn8CRsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZTmg2rr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33db19538d0so54822f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709153685; x=1709758485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrvSsn2Y3JHcwCC94OejcIaNxty8KECgxaLyHkTIkcY=;
        b=PZTmg2rr3F18AsdKbJNjgzXHqEzOkltKxJNDtuuydfqS1Q/j+XxMi7TMcjN7fsnBEW
         gtlraMczy9FxQLwwEwCNhvUiqO7KqrLAHp2OogN91MpQcaitfbOMa6lmyJBXWfWa+Lh2
         2DdwznlHy0OHYwiHeSVpQ7o0LsFBaa/FhsnslU+buCIocwdJIfhg2ejscENfQJVb7eAU
         JB1ZvlY62+0blsDhp57nR0GAqMm3MQPS8zeKRBB5iVrR7eueLMfsn1igclsxEwNPPIXb
         G9+Lrs6MN2MwJ6d195XDvJEGsUHb9u+YqsDyx6N/KJtqbxf6xtw58hvx99+ezG+dlFMd
         4/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709153685; x=1709758485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrvSsn2Y3JHcwCC94OejcIaNxty8KECgxaLyHkTIkcY=;
        b=MBW6VdzDw4k+Qs5097bkWDrkmCP0VR3WPMExINa2PFRIBCktydJAjIYPiESXt+65I8
         tIxK+GZwayfaAx89hwGmSLKvm3bEMAv0+flJtvvLMLIyzQGfFYt1A7QU5FBzmq91+ETo
         dS2m9q9FhP2cQZLlLzqeCZb5nSbvILkFgKlN2mGJD21vgnr0faX5Mkw8XhY6LYVskpVa
         fznEY1ga2Y58kzasHZecChcejUDxxsH2GoAOYye0kz3Rg5dD1EyAkGv0PhqeHkJVc9AB
         HHpkiWb0U+p7bt6LfTFD61jrsmnimvdt4FufN6TjKeE7+ZCTEFpboJKUvRVu/lveMGs4
         RH2A==
X-Forwarded-Encrypted: i=1; AJvYcCXsx8nUwUlbimJ8nDyVsCGdHtj4ubuz9CWjvH8l2y09SXoiwQnFTh/MEQZofS6VWWn0fBxWHHf3Q71vt1HzclQRdHf1zFlU3qe+Bvp/
X-Gm-Message-State: AOJu0YwuSIZhBt+GI3aPtzrqJxvEsyvrsQEkc3x7eNoTR7ztQlXUi1rp
	wTP50JxChBqtKXcpSMFG2tHkG85TFxnGl21xXrz1c1Dk8CNuVzea
X-Google-Smtp-Source: AGHT+IF2eAIUySWsP2UWaicEjzVUgQSBy609mW3QinTfuUseDGuRlZT/sba3etEew200ingFJFEPbg==
X-Received: by 2002:a05:600c:3ba8:b0:412:b2af:2632 with SMTP id n40-20020a05600c3ba800b00412b2af2632mr296571wms.0.1709153684492;
        Wed, 28 Feb 2024 12:54:44 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c4e4900b00412aff7874esm110765wmq.48.2024.02.28.12.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 12:54:44 -0800 (PST)
Message-ID: <ef46a014-279c-490e-bbe1-df4697415d59@gmail.com>
Date: Wed, 28 Feb 2024 21:54:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Staging: rtl8192e: Sparse warning regarding variable
 declaration
Content-Language: en-US
To: Ariel Silver <arielsilver77@gmail.com>, gregkh@linuxfoundation.org,
 yogi.kernel@gmail.com, dan.carpenter@linaro.org, straube.linux@gmail.com,
 garyrookard@fastmail.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240228072553.11740-1-arielsilver77@gmail.com>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240228072553.11740-1-arielsilver77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/24 08:25, Ariel Silver wrote:
> Fixed sparse warning: "'dm_rx_path_sel_table' was not declared. Should it be static?"
> As dm_rx_path_sel_table is used only in rtl_dm.c it should be static.
> 

Hi Ariel,

please use checkpatch to check your patch:

File Nr: 0    Patch: ../../../Downloads/20240228-[PATCH] Staging_ 
rtl8192e_ Sparse warning regarding variable declaration-14757.txt
WARNING: A patch subject line should describe the change not the tool 
that found it
#1:
Subject: [PATCH] Staging: rtl8192e: Sparse warning regarding variable 
declaration

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit 
description?)
#7:
Fixed sparse warning: "'dm_rx_path_sel_table' was not declared. Should 
it be static?"

total: 0 errors, 2 warnings, 0 checks, 8 lines checked

Please make a v2 with change description under the "---"

Thanks for your support.

Bye Philipp

