Return-Path: <linux-kernel+bounces-28545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5265E82FFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074A71F262D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300FD79DE;
	Wed, 17 Jan 2024 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vSDCu6/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B21C11;
	Wed, 17 Jan 2024 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705470283; cv=none; b=AdlDHS/YhyysfL6h4LHkCQC2KWzi9dVFbfZ2klSFXzkWnZtypeRjFcyjMH09qfWUOdFKpRK7qsACB90TWL8lvHE9OakpuJnrIpMQ+CXTtFeD1D15jkF+rhrVruzokccjs08PlivATsYLi57FiPaf7af0SIDpzRlsMzKLt+ZnDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705470283; c=relaxed/simple;
	bh=V2L/4fn7ZLWUHnTitT04jS9F7lFXCBOTYZt6nFAy4ik=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=VnJhIRPoZfMqpb1bjYZCkoPPQm0mD9xdI78VGy+YFA0ftB96cQk5ZF+keYgwCTtIxI/RmZXT5MZl1NJT0VzfJQjGDZ7YWhGwKFPBwZZij4Fq6FeGaRIWkN54ncoDokft/KvzcDv2kbBXnWSjSiwxMRveLVbBXtcJ+/CDKLm9rDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vSDCu6/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B658C433C7;
	Wed, 17 Jan 2024 05:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705470282;
	bh=V2L/4fn7ZLWUHnTitT04jS9F7lFXCBOTYZt6nFAy4ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vSDCu6/hjOJd0R/mRbuFBE/fIwsEPDc3YmzQy3DMgtmfoUFCq3MatUWHyi2Gn/LgV
	 kJhcfwtbHxfOZcRzzUdTmwSx8Xj7T2l3fM+NGSVqgvoshfPfQRdhGocD/I7CC6JyOb
	 gbQcqKtfNPlKG3eB/lqDyHp9L2XmnDZSLxIyb7Ns=
Date: Wed, 17 Jan 2024 06:44:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: ucsi: Add missing ppm_lock
Message-ID: <2024011726-exhaust-writing-29d4@gregkh>
References: <20240116224041.220740-1-lk@c--e.de>
 <20240116224041.220740-2-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116224041.220740-2-lk@c--e.de>

On Tue, Jan 16, 2024 at 11:40:39PM +0100, Christian A. Ehrhardt wrote:
> Calling ->sync_write must be done while holding the PPM lock as the
> mailbox logic does not support concurrent commands.
> 
> Thus protect the only call to ucsi_acknowledge_connector_change
> with the PPM lock as it calls ->sync_write. All other calls to
> ->sync_write already happen under the PPM lock.
> 
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
> NOTE: This is not a theoretical issue. I've seen problems resulting
> from the missing lock on real hardware.

What commit id does this fix?

Should it be cc: stable?

thanks,

greg k-h

