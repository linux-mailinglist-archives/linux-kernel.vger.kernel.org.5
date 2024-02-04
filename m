Return-Path: <linux-kernel+bounces-51727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D60848EA2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD9F1C209B9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3021340;
	Sun,  4 Feb 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN8bTO3Q"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA624A0D;
	Sun,  4 Feb 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058155; cv=none; b=WWXtcRJPeN9ROt48Ll1WZxkC8sgSQnbcYabCUKtjEf2qwp/vjEnwejXZg7xDNL1pBUUDSMEHZWsL0ij5OELnYhxXHqgKOX96cRTSsKCAmXZSTMo5s/UhRYbID1YAj+6WuJBEzVk5Yh6Qk8u/nFX9GBqZ776y+HM+quIoUMZtkD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058155; c=relaxed/simple;
	bh=UO2hnUkxZW3kgQmzeSCEJBa5rIWlJyB7ZWW2ErVGQsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyaDsCtY5A6u+/WjDT9etVyAvsAIm3rsG4Qb/sKcMWzmY7ttzwLE8uRbfBDtSNABqGuS8TtjznsOUMdi1N/VU8V/mg4Ho86Xorolw/X7v1STReDht1Q2p6NzJNfT5aS0quWVLkvX/BES22AMdDH2YvsHhn4ovZMKgngL29geo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BN8bTO3Q; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c00128de31so141444339f.3;
        Sun, 04 Feb 2024 06:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707058153; x=1707662953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tS11s01N9W8G62GBdNlHmo/I6D3Ch5XK0GqtBFBBIZw=;
        b=BN8bTO3QZWSVCAKOgSMyd9zLXXyi4daW8mMLeCHz5TLTCW8m5eVxYBSq0rgONmwhz7
         02++DFtQy7rjWAfVyHpB+zKeMs3h7hvF1kmJGj45H72eBis0M6MmM3KzLkfSNvryQaVe
         PF4wi5wfR6DHMfcBWPtjOlfiz+yh101d9IvjnqdyazsFUhl8ffrlBg8V421OuogjrNLV
         ZmkS1K/iB74+xufCKgN1uMeYVfE7/or8pW9wu6WzlQUw0s0WqBbRiTTyBON5KZlCp35H
         zNTrNy3PIx6iriDfv7S7KWkf36K68DI6yLTLxaiyzvoD6Q6s7VojFV/SDV21FcTMxOte
         fYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058153; x=1707662953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tS11s01N9W8G62GBdNlHmo/I6D3Ch5XK0GqtBFBBIZw=;
        b=s7s76PgPfm5L5FjZ94cj+uqM1uYQ6MazEZGmFhegoEb4qTDDH4tqwsKDWjdjuYfNTX
         SocG4ofpezKSQ+O6gXj8R5g/OQ/BqVA2vn2oGaqtaDoY14uJ4f5m+4MAnoSHGTpmWmEs
         2i68plom8Mpmp5gdZObGMB4e2zA2W6bxzwH7epc/r75WuXiMcTJgrJVQ6qvL0Brojq6M
         5yO7Ny2Pccd98LvjwniPsddNAcoatkGBBcRc2/6afkVUJi/lkSzaxpgmim0o0fRHh1x5
         5P+SHhFALjPDbLmr2BUgETtyyyNq7DiSBW9iEkUOfJUM7EFe/LakcBNq4TmjFjf3YEA8
         dgSg==
X-Gm-Message-State: AOJu0Yw6gds66Qe0UQR7+fz7lktORIKWCzQQEJvDeiJ1TLS2C+1fb2Nv
	ihoFX+dcbU8eD8JDi4Y2r5ztB5ua9de5bbINNXPtdwllLk76uSwV
X-Google-Smtp-Source: AGHT+IHAHAq0g3yElN1drMWzNPBVtTwD7xoJjvU4A0o9M/AjlGW9fe2k3HWc99PN5RSMqGc99ZTQzQ==
X-Received: by 2002:a05:6e02:792:b0:363:c4ae:95c5 with SMTP id q18-20020a056e02079200b00363c4ae95c5mr2217622ils.17.1707058153219;
        Sun, 04 Feb 2024 06:49:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVvvI3nkc03G7ZmClhHUylzm3qTFHyCpmTpRfGvdVhmhrmSPfhDVCSagO3LlQszQ8GhRMhHxAjYjhAQJk0Hwklp01wTDCCPyc1XbbBHY5ICUN3S4B2PG4NUfyZKvlQD4HomfRGP5biS3EoBrEcOUkDGvWRFV/4VzO81kq7vBg4k
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i17-20020a63cd11000000b005c6e8fa9f24sm5267446pgg.49.2024.02.04.06.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:49:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Feb 2024 06:49:11 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Rui <rui.zhang@intel.com>
Cc: jdelvare@suse.com, fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 10/11] hwmon: (coretemp) Remove redundant
 temp_data->is_pkg_data
Message-ID: <a12fdf3c-b8d6-4deb-9f02-8b34586af836@roeck-us.net>
References: <20240202092144.71180-1-rui.zhang@intel.com>
 <20240202092144.71180-11-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202092144.71180-11-rui.zhang@intel.com>

On Fri, Feb 02, 2024 at 05:21:43PM +0800, Zhang Rui wrote:
> temp_data->index saves the index in pdata->core_data[]. It is not used
> by package temp_data.
> 
> Use temp_data->index as the indicator of package temp_data and remove
> redundant temp_data->is_pkg_data.
> 
> No functional change.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

