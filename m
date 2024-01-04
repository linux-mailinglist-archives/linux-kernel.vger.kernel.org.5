Return-Path: <linux-kernel+bounces-16830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78FF824493
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA60B24061
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F263728E0A;
	Thu,  4 Jan 2024 15:02:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6B06C23769
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 382083 invoked by uid 1000); 4 Jan 2024 09:56:11 -0500
Date: Thu, 4 Jan 2024 09:56:11 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Udipto Goswami <quic_ugoswami@quicinc.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Prevent null pointer dereference in
 update_port_device_state
Message-ID: <1fafda18-8806-4036-bcc1-ac08e2d3b9cd@rowland.harvard.edu>
References: <20240104102616.20120-1-quic_ugoswami@quicinc.com>
 <2024010447-sprite-shelter-0743@gregkh>
 <eade09eb-4454-460f-9ce6-87da986c5acf@quicinc.com>
 <2024010432-fifth-shakable-0d84@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024010432-fifth-shakable-0d84@gregkh>

On Thu, Jan 04, 2024 at 02:13:51PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 04, 2024 at 06:35:38PM +0530, Udipto Goswami wrote:
> > Hi Greg,
> > 
> > On 1/4/2024 4:14 PM, Greg Kroah-Hartman wrote:
> > > On Thu, Jan 04, 2024 at 03:56:16PM +0530, Udipto Goswami wrote:
> > > > Currently,the function update_port_device_state gets the usb_hub from
> > > > udev->parent by calling usb_hub_to_struct_hub.
> > > > However, in case the actconfig or the maxchild is 0, the usb_hub would
> > > > be NULL and upon further accessing to get port_dev would result in null
> > > > pointer dereference.
> > > 
> > > Is this true for any real (or fake) hardware?
> > 
> > We saw this in our QCOM hardwares where lvstest.c was calling
> > get_dev_desc_store:
> > 
> > 	usb_set_device_state+0x128/0x17c
> > 	create_lvs_device+0x60/0xf8 [lvstest]
> > 	get_dev_desc_store+0x94/0x18c [lvstest]
> > 	dev_attr_store+0x30/0x48
> > 
> > I think the part of the test procedure is to first unbind the hub driver
> > which calls hub_disconnect setting the maxchild = 0.
> 
> Are you sure lvstest is correct here?

This is what happens when people work behind the hub driver's back.  :-(

If you can't find another way to fix the problem, you should at least 
change the patch to include a comment before the "if (hub)" test, 
explaining why it is necessary.  Otherwise somebody in the future will 
remove the test, because under normal circumstances hub would never be 
NULL here.

Alan Stern

