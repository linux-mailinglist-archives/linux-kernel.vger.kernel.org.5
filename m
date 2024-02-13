Return-Path: <linux-kernel+bounces-63729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5C08533C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC9C1F2C4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E4A5EE7F;
	Tue, 13 Feb 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rfyQAM/O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702057873;
	Tue, 13 Feb 2024 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836088; cv=none; b=q33zg6qwpX5TmhXhJXurJzq03mchHfvv98Narv3/2TWFLm4+Fgg8f56CFxa8CVWOimHTjEKYNdQS0IkpH4LY/qHW/sg5t73kEMnhyQbHLsVgd/nNyhNNxPN0xCaF0yUCh5sZXiuB4SOXIA93h5AzvLe3mZNeJ2mXtnvCc6O6+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836088; c=relaxed/simple;
	bh=M/B+3yw64jbG6sFisbulB5VVpBChPxrc3SPUXNhkWiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPWIcOy0ua8YI7Fc5Yl6s9FxwWEj9cYyM9ZjMbWJyiI2ASLDegjXGT36tfvzqCCiF8z+xFZ52rWdL94RryNhW3BF+/k7+g2aIyUqzj1OWpaci9B+WMCSE4ic5rh3a2+bUY2Slptoi+Lkf+UfcvR18WQcZ8uRvJhBY6lXaQVJ8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rfyQAM/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98077C433C7;
	Tue, 13 Feb 2024 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707836088;
	bh=M/B+3yw64jbG6sFisbulB5VVpBChPxrc3SPUXNhkWiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfyQAM/Oau8KINFZBl3gA4Bu4iUCvDZgr+F8N8k59QnUii4xQRcOW9C6XRUQAO6xf
	 WuLgQ3ZCto8hbVW9ciwakU3F3aITes1//fGc58/jomutcCwJFWgA/+sSyWmdpMPJBz
	 b1GIdanQsvvyTnhPIbVzJhZgXbQ/Vmpsgd44AoCE=
Date: Tue, 13 Feb 2024 15:54:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: kovalev@altlinux.org
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, u.kleine-koenig@pengutronix.de,
	a.firago@yadro.com, sashal@kernel.org, zhuning0077@gmail.com,
	tiwai@suse.com, perex@perex.cz, broonie@kernel.org,
	lgirdwood@gmail.com
Subject: Re: [PATCH 6.1.y 0/7] ASoC: codecs: es8326: fix support
Message-ID: <2024021335-mourner-impurity-82bd@gregkh>
References: <20240130094708.290485-1-kovalev@altlinux.org>
 <2024020205-suffering-paparazzi-8a49@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024020205-suffering-paparazzi-8a49@gregkh>

On Fri, Feb 02, 2024 at 05:13:50PM -0800, Greg KH wrote:
> On Tue, Jan 30, 2024 at 12:47:01PM +0300, kovalev@altlinux.org wrote:
> > These patches were backported from v6.6 upstream and
> > are intended for 6.1.y stable kernel.
> > 
> > Patches have been successfully tested on the latest 6.1.75 kernel.
> > 
> > [PATCH 6.1.y 1/7] ASoC: codecs: es8326: Convert to i2c's .probe_new()
> > [PATCH 6.1.y 2/7] ASoC: codecs: ES8326: Add es8326_mute function
> > [PATCH 6.1.y 3/7] ASoC: codecs: ES8326: Change Hp_detect register names
> > [PATCH 6.1.y 4/7] ASoC: codecs: ES8326: Change Volatile Reg function
> > [PATCH 6.1.y 5/7] ASoC: codecs: ES8326: Fix power-up sequence
> > [PATCH 6.1.y 6/7] ASOC: codecs: ES8326: Add calibration support for
> > [PATCH 6.1.y 7/7] ASoC: codecs: ES8326: Update jact detection function
> > 
> > 
> 
> What exactly is being "fixed" here?  Was the driver not working properly
> in 5.15?  What broke in 6.1?  Or has this hardware just never worked?
> 
> These all don't seem to be fixes, so what is the need for these?

Dropped from my queues due to lack of response :(

