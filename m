Return-Path: <linux-kernel+bounces-16693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF701824288
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083FDB23582
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6A22338;
	Thu,  4 Jan 2024 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rog4gwco"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9B22313;
	Thu,  4 Jan 2024 13:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AE0C433C7;
	Thu,  4 Jan 2024 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704374033;
	bh=VOJ4TOzf0UAb3CYkaYfqXUT1K2mGh/tBfWX8UVL7014=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rog4gwcoFq0XA6IYXBXaYoPu2pPOYcPp3VUinYVysvX7iIFecNlid2YnKuCtQ88+u
	 z01tEqmI8tac+nIB8SaJN9+J6EwRr7GRqS5T6G63WXipfJ+M+gX2H9b7QtFLwWWqZB
	 d0QWeQW/tlMQiz5Gaqdg/Xy8p2YoTJbsMEm/W3NQ=
Date: Thu, 4 Jan 2024 14:13:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Udipto Goswami <quic_ugoswami@quicinc.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Prevent null pointer dereference in
 update_port_device_state
Message-ID: <2024010432-fifth-shakable-0d84@gregkh>
References: <20240104102616.20120-1-quic_ugoswami@quicinc.com>
 <2024010447-sprite-shelter-0743@gregkh>
 <eade09eb-4454-460f-9ce6-87da986c5acf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eade09eb-4454-460f-9ce6-87da986c5acf@quicinc.com>

On Thu, Jan 04, 2024 at 06:35:38PM +0530, Udipto Goswami wrote:
> Hi Greg,
> 
> On 1/4/2024 4:14 PM, Greg Kroah-Hartman wrote:
> > On Thu, Jan 04, 2024 at 03:56:16PM +0530, Udipto Goswami wrote:
> > > Currently,the function update_port_device_state gets the usb_hub from
> > > udev->parent by calling usb_hub_to_struct_hub.
> > > However, in case the actconfig or the maxchild is 0, the usb_hub would
> > > be NULL and upon further accessing to get port_dev would result in null
> > > pointer dereference.
> > 
> > Is this true for any real (or fake) hardware?
> 
> We saw this in our QCOM hardwares where lvstest.c was calling
> get_dev_desc_store:
> 
> 	usb_set_device_state+0x128/0x17c
> 	create_lvs_device+0x60/0xf8 [lvstest]
> 	get_dev_desc_store+0x94/0x18c [lvstest]
> 	dev_attr_store+0x30/0x48
> 
> I think the part of the test procedure is to first unbind the hub driver
> which calls hub_disconnect setting the maxchild = 0.

Are you sure lvstest is correct here?

thanks,

greg k-h

