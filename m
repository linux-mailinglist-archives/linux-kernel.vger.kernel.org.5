Return-Path: <linux-kernel+bounces-78821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D66861952
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2115E285071
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498CB1C68E;
	Fri, 23 Feb 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5rr+wfR"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5512AAE0;
	Fri, 23 Feb 2024 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708957; cv=none; b=AI1UlayPsMQUgI4vFyNLgLT00yPUQPVkO5ZV5RDL/dFRIeLJunOvC5LF2ptN1O0VblNa2ZlZ2kGsXE1R2lyljvMdjHU1Due80GZu52XdM61qNDXglb0Mdj1WuQPV+TgG1u6ezNzVo+hJWWuw3l2jjrGkybyoWeKMMtsoWS2j0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708957; c=relaxed/simple;
	bh=SvkupoeribjXt1qO0/10r6stz8J1dmq6EiW8AL+wx9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOmKGNFiIGIC/xN2lIMAlpWBnY5l6pgS72wsrbVL1PmpAK56kE0jCZBMRhBuhjEQtXwB0yAgIRGiQmqHq4Agnx8WnUYohnWW/t3svaerdd8p5DfTFKyCxNcvUxHZjngh8U1m9bzsMmQcycxO9trrrNZbLXV8hKMAgsbDfRZtIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5rr+wfR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d918008b99so4596025ad.3;
        Fri, 23 Feb 2024 09:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708708955; x=1709313755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1qB8qiWWm1+KnuGpJ58yy4A/Vx3gsfPagJr/34wvao=;
        b=B5rr+wfROEtXCdlfWTJeQGMi5+q8CVaOgwOxbIyG2NpZVB1lPyh5MpQJamCxMonjcS
         sc3qcr/evyucx1roBLrMPvepOoRzp4aPJaxNxd+/7kyL/quDXWCrmF6znqjoro11urhd
         EsRKiaRyeR9Oz/Tf2Ucwf7OpjcZSxg6RAl8fIPzIEvcbiwcZR+mexlhlKMyqNIKPVsST
         RGmiFHSqyUai/RUPU5Ed0MwpsMqdgNIorAxy3Gbi/5Ob06vJ8kfF5Gwa5XOFlMyoNloJ
         3IAWmeTp3hkzsY0vpuKhgAtGuGuJeq9yVtEw/JBgvu9E53In5ez2qoJnBCIs+0iURQ9q
         rC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708708955; x=1709313755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1qB8qiWWm1+KnuGpJ58yy4A/Vx3gsfPagJr/34wvao=;
        b=KU8VlvL5vMCSIqUtKYc2v5r876LLeX9c+lE8FxmqQl3/U1JI8rMPGKgTh6vlG4gfG0
         yjeI0d8b7aDBLyJT9psqV9WL5hXRnG9TyGXf61ea+TmU60V48zDakpnbB3IWzVsEd8tO
         Y8C108mENw1WGMNzQcs7GneOQcx8WpMzkwSC40deMxTPjhlTHJIrSG6qt/cMjd+LFT/t
         I8SzlOP+PhxsHEVwki3D4kY8lNqj6QufJcK9gMnSjwXwulkr9R1OJxuNB6JXc1n+X0KS
         4q9Jz6AS5iu62bm9j/poEXvZu04aGxiLS2BdYBKQmOeCWS4ToV4XRFGeuZF/C2lu2P8H
         A0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVPesz+6sjUbaeVJwbhrcxkPqM7uwQ+cvnwL12792tr5gXTxI92pKTbIflegZ+4oeqEqGyvmmR+TWO+ilO/aCMW53txzOTqski1aJL64K6EJe2GMWhSLS4an2KbKHm8kG2tclUI
X-Gm-Message-State: AOJu0YyB4VOYdnAx6wdQu0JOLfiH3airJuX5Hye6aVXLLTBBrPAjoGgV
	9xH3kg0g21MQUrJjQUqUTXRYjgwSMegV62hQ5JRgKi/oDiq3K3AE
X-Google-Smtp-Source: AGHT+IHsUCKVimVlZp1C0rBkdkNvHrz1AxRrnvYYXHkv5kCUK97hyDvETtILF5TK+bLfMS/m69cSpg==
X-Received: by 2002:a17:902:ee84:b0:1db:e837:4091 with SMTP id a4-20020a170902ee8400b001dbe8374091mr420817pld.3.1708708955358;
        Fri, 23 Feb 2024 09:22:35 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ce8400b001d95d47cce4sm11875205plg.138.2024.02.23.09.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:22:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 23 Feb 2024 07:22:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mikulas Patocka <mpatocka@redhat.com>, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com,
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com,
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com,
	Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
Message-ID: <ZdjUWVkLbxSmJS48@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>
 <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
 <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
 <ZbrgCPEolPJNfg1x@slm.duckdns.org>
 <ZbrjhJFMttj8lh3X@redhat.com>
 <ZdUBHQQEN5-9AHBe@redhat.com>
 <ZdUGFqLCpWez42Js@slm.duckdns.org>
 <Zde7nXVx8oFepINV@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zde7nXVx8oFepINV@redhat.com>

On Thu, Feb 22, 2024 at 04:24:45PM -0500, Mike Snitzer wrote:
> I've rebased and made the changes available in this dm-6.9-bh-wq branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.9-bh-wq
> 
> I left them both DM conversion commits attributed to use despite the
> rebase (and churn of renames I did in the dm-verity commit); hopefully
> you're fine with that but if not I can split the renames out.

Looks good to me.

Thanks.

-- 
tejun

