Return-Path: <linux-kernel+bounces-132922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F3899C0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE202840B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDC616C6A0;
	Fri,  5 Apr 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1r3AAq8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15316CDB7;
	Fri,  5 Apr 2024 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317652; cv=none; b=kvS399aZb206lunA3AyJ1rufJLClbVpawFYTvazKjTvutxk0peMWANFs4VewWgf2ksSFAPdrXDX8+1jhNwkiiIwhlMSt8hQ4dwTtm/POSteN90COtdSX66s4DXJHicSu9l5TQkTPB9srKQlHqRFPEVDqMJrOATG0sHFF+Nf5j2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317652; c=relaxed/simple;
	bh=DvKJWYggCWh8qsjlglovNAH159U7MAewA0OxcfyHmMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSwweWDl+QnmO+ZWZVh4dwxFxQKPxhjzdjHu7h51Surb3kItIdkADJ+aMB06T1waWhJoUCk/KxUYUahF3ojOaB3Qbz+Di6TtZzwDWfbiFiqdh0bJk0XXkI2q3x0s3bYC/5SS2OSOJreyW7A0mTb5k2DT5M8G05Dty2+VGWtD56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1r3AAq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19DDC433C7;
	Fri,  5 Apr 2024 11:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712317652;
	bh=DvKJWYggCWh8qsjlglovNAH159U7MAewA0OxcfyHmMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1r3AAq8rG6agZ0h394b8G6DI2ZtudUMm5j9cuQBMv2siRMN6hTcARQq5HL4SQRS/
	 1oTSxSBlMrI480L+ARtYPRsQ1kXqHkttxYZttBFhJ0XB+Ff+Mjg90yt+8rzZCp6oc5
	 jOF7KMf9WzDhVmz5TbdiaL4QmZ/V2ja1KgySlkJW39kOkMCtogWGXcxxWJu0E5ZF81
	 ttnqW1ByP09fTZshu0oiSi7JSig9dPJNOkQ/2QV6wTTIsTcIpZHDc11dIpg9GJacBt
	 OU5PHa1CiI17EpbZFxoLsb4ou0gTiu7OEHhBsw3l+e3j8gS194NUO96i0XyWIPlqer
	 QRDsvljyndIIw==
Date: Fri, 5 Apr 2024 17:17:28 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 7/7] soundwire: bus: add stream refcount
Message-ID: <Zg_k0IsnvjXlr1Jp@matsya>
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
 <20240326090122.1051806-8-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326090122.1051806-8-yung-chuan.liao@linux.intel.com>

On 26-03-24, 09:01, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The notion of stream is by construction based on a multi-bus
> capability, to allow for aggregation of Peripheral devices or
> functions located on different segments. We currently count how many
> master_rt contexts are used by a stream, but we don't have the dual
> refcount of how many streams are allocated on a given bus. This
> refcount will be useful to check if BTP/BRA streams can be allocated.
> 
> Note that the stream_refcount is modified in sdw_master_rt_alloc() and
> sdw_master_rt_free() which are both called with the bus_lock mutex
> held, so there's no need for refcount_ primitives for additional
> protection.

This lgtm, I would like to see this patch with its user when you
allocate BTP/BRA streams

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/stream.c    | 5 +++++
>  include/linux/soundwire/sdw.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 4e9e7d2a942d..7aa4900dcf31 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1181,6 +1181,8 @@ static struct sdw_master_runtime
>  	m_rt->bus = bus;
>  	m_rt->stream = stream;
>  
> +	bus->stream_refcount++;
> +
>  	return m_rt;
>  }
>  
> @@ -1217,6 +1219,7 @@ static void sdw_master_rt_free(struct sdw_master_runtime *m_rt,
>  			       struct sdw_stream_runtime *stream)
>  {
>  	struct sdw_slave_runtime *s_rt, *_s_rt;
> +	struct sdw_bus *bus = m_rt->bus;
>  
>  	list_for_each_entry_safe(s_rt, _s_rt, &m_rt->slave_rt_list, m_rt_node) {
>  		sdw_slave_port_free(s_rt->slave, stream);
> @@ -1226,6 +1229,8 @@ static void sdw_master_rt_free(struct sdw_master_runtime *m_rt,
>  	list_del(&m_rt->stream_node);
>  	list_del(&m_rt->bus_node);
>  	kfree(m_rt);
> +
> +	bus->stream_refcount--;
>  }
>  
>  /**
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index e3a4bccc2a7e..71a7031f7b3a 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -902,6 +902,7 @@ struct sdw_master_ops {
>   * meaningful if multi_link is set. If set to 1, hardware-based
>   * synchronization will be used even if a stream only uses a single
>   * SoundWire segment.
> + * @stream_refcount: number of streams currently using this bus
>   */
>  struct sdw_bus {
>  	struct device *dev;
> @@ -931,6 +932,7 @@ struct sdw_bus {
>  	u32 bank_switch_timeout;
>  	bool multi_link;
>  	int hw_sync_min_links;
> +	int stream_refcount;
>  };
>  
>  int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
> -- 
> 2.34.1

-- 
~Vinod

