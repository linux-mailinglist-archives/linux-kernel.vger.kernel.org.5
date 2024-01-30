Return-Path: <linux-kernel+bounces-44887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292884288F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12FA288F37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D54786AE5;
	Tue, 30 Jan 2024 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noBBIrpV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9F85C67
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630417; cv=none; b=WE3Kwtuh0sCkbuOLUwk3NSjjaRvVKJrMz61FRSeXcjgb/ks4LWPIqJR76jalVhTE5zzavNMlSi/gbIgvy4n7jI7YrVifBL/23NveuL5SFsmMwqinGA7i4HZPmgnSu/wjbP0pzA5gvTDgbCPibg7oxzy2NNArRW2ZyeyHdzmBGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630417; c=relaxed/simple;
	bh=b8i2Ikqa5Isp1hTL6r1iKRXe/yBNaJv7nEw/sg4+Fto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wj7BCAPpnMMNrLnEgbzyZ6NlH11ORR/PCqwe/2iCNQDpMYOQCU5T5BPj0kGE5emswDz7Rj7l8w2NMXGhRHrQ0jpHQQPeiY8FsDDpNOFhuBv5F+2DZPrtadh0oOhLgdiul5x4t1Cs4RmGWLSj37eqhhXjUtluxd3urBOc26SJbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noBBIrpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C9BC433C7;
	Tue, 30 Jan 2024 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630417;
	bh=b8i2Ikqa5Isp1hTL6r1iKRXe/yBNaJv7nEw/sg4+Fto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=noBBIrpVpUGmdyuqTZlL9IsgEuy8Jh9xZUF1EMV/uqKDB7q2R1v5PAYP4iUUexVAb
	 yOQI0dT+PxwTgmrAaP7v/eBV/IYZ9Im8C1XV5xfntJEmj7wJeX3ITgfZsM6BaIg+54
	 IUgpXo1/vuAYWDFo6ajtXD25wsNNaUSvbqTlppGS3obJC5s3TfVrZ0XX8i9AJI7i/E
	 uJy63vEf5cfd+N7+QeXHjzyZJlMJWZfzXq82atkn6ytzjHByzzv6trtZgxUwBL8/3K
	 am+pMz62BDA/c2W3rKZ4TxsgKhVfLxF7pAG8iSdva3BttNUxkTYb+I1aaKou7NojXd
	 IKLkrrXon7TGg==
Date: Tue, 30 Jan 2024 21:30:13 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, vinod.koul@intel.com,
	venkataprasad.potturu@amd.com,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 03/13] soundwire: amd: refactor amd soundwire manager
 device node creation
Message-ID: <ZbkdDUh8hJ4WTQ_W@matsya>
References: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
 <20240129055147.1493853-4-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129055147.1493853-4-Vijendar.Mukunda@amd.com>

On 29-01-24, 11:21, Vijendar Mukunda wrote:
> Refactor amd SoundWire manager device node creation logic and implement
> generic functions to have a common functionality for SoundWire manager
> platform device creation, start and exit sequence for both legacy(NO DSP)
> and SOF stack for AMD platforms. These functions will be invoked from
> legacy and SOF stack.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

