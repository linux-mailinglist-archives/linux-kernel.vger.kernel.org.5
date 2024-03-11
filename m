Return-Path: <linux-kernel+bounces-99436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8E9878849
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558781F2245A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483F57864;
	Mon, 11 Mar 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8hihn39"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2895D464;
	Mon, 11 Mar 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182744; cv=none; b=By71yj/F74lN+2ow5WoovtTsD73fRIIxtYg2wxrdjB1tgco22NKNhSaz6B0hxwXImaJ5A7FnRJMKb17qzMM4BGZpmTOMGWhlrEpp6J6RiCo5cDkj5pxSFsdRZhznddxQObuM6fqPJ+CsupXDLBQXCh2UholNaxeRKbZId56gyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182744; c=relaxed/simple;
	bh=YhOHMWjkcUzXIED148TTJXrskfLAfL9srHM7kYXxEN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIpB3gt+pb2Yndgy1c/v6mmV2WzDIvemDz4idcqfMzTF0TGPD9j6GfGW0Cw2I0QF25YsaF1aEASwoeUl0b9W8oUx+/z6BKpwBZxQbZKXutFJq0tV08KX0PiFEMiC73raow7kTIj7Q5aM/22rj+z2iebQBm+G8XazeAGmQghSCJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8hihn39; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso2676491a12.1;
        Mon, 11 Mar 2024 11:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710182742; x=1710787542; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tZJVptozyO4U9eoAV1lEXZFvnlnohiXBEJs1F4MzQv4=;
        b=E8hihn399fGIn0n5oK40oNLAIFIGCr6fkBrgS0fEhUNLjY/Lgl/JcomDkSAfjY6FNf
         K3LoOOzxwcFx/jiXLbBFEuNo01GQHAIHvMGiTmIA8/UzLatqBQCfdReqr4b4yTqUAVIk
         hxlINnHCPPCpojcb3l8Kj54aEoPEF2IV0YQanysCym29R5m/BD4U9xGPaw6boamT/oRa
         7anKl41iYxtBGL7z9uRQm88iy868bmIzId+bveN8A4b/ojMFxeTws4fHjZXb/qxbNA1g
         2dPX6YdVIaJf6/4QCCoDrwi7/yPVt3tLZ78Vs6c8v0/GUGoMJOhBBJsDYvu1PK9AEpgZ
         vs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710182742; x=1710787542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZJVptozyO4U9eoAV1lEXZFvnlnohiXBEJs1F4MzQv4=;
        b=wT6Qb+HCgGsvCsh03UDsp/+fwDyrRJG7lMoEoEypAA6MCjY8/RZSQcTiSqWkdXdaW2
         qk9V8AvKK0XqgzqUPoVybg/aK+ycHKMcr6AZa5MNqIX7yGyPlZhzL59uQP5tCHWP3S51
         fnzJj/5TaZkONRv66sPjt2vcUeFHPQ8bber7AWfV8p1ClCc0ikNPt1AVrPXCiFPjyNVO
         Hm8yvRqzDkO0h8zMCeeY+2SlPOZ/scV9HvKYzgrxecdxOWArVbW1zQ7qOs6T3O6RYWLx
         w5X40cCLlbhb7ZTfuTvOD/qIwGI8BIEJXaKVayZyOnud5i6oziXqvZFXOV4QDMyrHt4k
         b14g==
X-Forwarded-Encrypted: i=1; AJvYcCW+W9MsKz4ARwztmlbK4xApuu1+GKh/kllAuk5CKsJx5+f4NUODcwRqhMSWNZj//yolRVwMnbL3hLet5psbDfnEKSICG4TAXCNtox8nIHysQVrNcWmgTZgsabj6K5df+L+Fba7Aia8zy4jY0xvKOIUFBrf6Z7O1qR9wiA4yMxPFKsJpD3M7vn28f+aE6RLg
X-Gm-Message-State: AOJu0YwZLUeCXvIxRiVOFmP4npUQ1IarU61LKUPhHg8yuhAoOdx3DlrM
	KzeyzBoMLuNQpR4GbHE9/frJ/gJT5BsNp0D1PWA4JeV59kSYCK4PgUvYZoIw
X-Google-Smtp-Source: AGHT+IEP2WQw4BdxkDhx4mHDy2GCkmkazyh/kAwWEXEcVSX6EfOwBcl8Le+/xIYGxsb5mCEMAnwIdw==
X-Received: by 2002:a05:6a20:e196:b0:1a3:1aee:c1a2 with SMTP id ks22-20020a056a20e19600b001a31aeec1a2mr2037900pzb.62.1710182741753;
        Mon, 11 Mar 2024 11:45:41 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:539:3ac9:e65b:d64b])
        by smtp.gmail.com with ESMTPSA id cv8-20020a17090afd0800b0029bcf62e296sm4013621pjb.42.2024.03.11.11.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:45:41 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:45:39 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ike Panhc <ike.pan@canonical.com>, Hans de Goede <hdegoede@redhat.com>,
	Philipp Jungkamp <p.jungkamp@gmx.net>, Gergo Koteles <soyer@irl.hu>,
	platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/2] map Fn + R key on newer Yogas and Legions
Message-ID: <Ze9RU8Mbnl-w8ZUL@google.com>
References: <cover.1708399689.git.soyer@irl.hu>
 <170895405312.2243.4199399921923370447.b4-ty@linux.intel.com>
 <Ze0PSaOQSJMxL_Ln@google.com>
 <269b8adf-426a-b614-5450-383cde095c75@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <269b8adf-426a-b614-5450-383cde095c75@linux.intel.com>

On Mon, Mar 11, 2024 at 12:53:36PM +0200, Ilpo Järvinen wrote:
> On Sat, 9 Mar 2024, Dmitry Torokhov wrote:
> 
> > On Mon, Feb 26, 2024 at 03:27:33PM +0200, Ilpo Järvinen wrote:
> > > On Tue, 20 Feb 2024 04:39:34 +0100, Gergo Koteles wrote:
> > > 
> > > > This patch series adds a new KEY_FN_R input event code and map the
> > > > Fn + R key to it in the ideapad-laptop driver.
> > > > 
> > > > It affects two WMI keycodes and I couldn't try the 0x0a, but I couldn't
> > > > find any indication that the refresh rate toggle should not be Fn + R.
> > > > 
> > > > Regards,
> > > > Gergo
> > > > 
> > > > [...]
> > > 
> > > 
> > > Thank you for your contribution, it has been applied to my local
> > > review-ilpo branch. Note it will show up in the public
> > > platform-drivers-x86/review-ilpo branch only once I've pushed my
> > > local branch there, which might take a while.
> > > 
> > > The list of commits applied:
> > > [1/2] Input: allocate keycode for Fn + R
> > >       commit: 4e45fa464aeef4e803412b5dcce73aad48c94b0e
> > 
> > I am sorry for the delay, but instead of defining a generic name we should define
> > a proper keycode for concrete action even if nothing is printed on a
> > particular key on a particular device.
> > 
> > Please drop this patch.
> 
> Dropping them at this point would bit of a hassle due to backmerges of
> fixes branch.

You should really wait applying patches affecting other parts of the
kernel as well as UAPI until all maintainers responsible for them agree
with the changes.

Thanks.

-- 
Dmitry

