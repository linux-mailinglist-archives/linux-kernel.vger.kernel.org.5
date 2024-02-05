Return-Path: <linux-kernel+bounces-53345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D936784A380
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2006B263F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB59664D6;
	Mon,  5 Feb 2024 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ciCvQyym"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186686EB70
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159799; cv=none; b=X28RqrpESQU/GRA3ey9WOmyPSNktExAms/9xSn6ynmD40Lw0d0ix1+e4ZuhQm3eW78+oM1VSM+Z2fmmGh5dshX/b8m7GOyCT+YKJx+eiS6Q50+eHIDzJ0Zk6E08+OTIL63kJv8egOUScWganpk0L1+Xs/jpxAWLphIxpqyWQBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159799; c=relaxed/simple;
	bh=SaE5fyHUUm1NkAMFFfv91SoNo9DgaZQmpck7+KsBLoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOE0kvS7kuv0QAqb61Eh5BBq23bEG2RGzRlMX+8gCRbg9QjroB6xCn/j/QY9VlAFmO5E24HRmuDYdDndnj47EGwp6Zwhyx+pldFm3zPDbh1FtuzFw81qgYnAK7/gokdKfXoMtjbRqgScYd/ajHdiUDMw+SG/e23bt0RQTgw/DJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ciCvQyym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A62C433A6;
	Mon,  5 Feb 2024 19:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159798;
	bh=SaE5fyHUUm1NkAMFFfv91SoNo9DgaZQmpck7+KsBLoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciCvQyymBxhKwoAIvb1VMfW/wdYgjc/oGsTxnMcmsXJlZogWru271dn4RfWGey4Tx
	 uSXLb0p3WEG/6Nd4ubtzFqJsEqxQX9eCVh/oCVuLSMM+Z/FFCf9F/CI29pcAY1NDPC
	 +6nXisUB1uyKbH7SuPxD0fJoZTxMeCXaYG/7v6mo=
Date: Mon, 5 Feb 2024 04:47:16 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport: make parport_bus_type const
Message-ID: <2024020510-october-lividly-83fa@gregkh>
References: <20240204-bus_cleanup-parport-v1-1-e6a0f756bbb8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-parport-v1-1-e6a0f756bbb8@marliere.net>

On Sun, Feb 04, 2024 at 05:25:51PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the parport_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

