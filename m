Return-Path: <linux-kernel+bounces-83655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42C869CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456F3283BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B438839856;
	Tue, 27 Feb 2024 16:53:29 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF88219ED;
	Tue, 27 Feb 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052809; cv=none; b=KVBJfYxIwAmrekBZXbtx+sHJC99nkWLsENPRIoSnQ1Km/I9rnQiAr6DQ8Q/xIqHgqxazBMU7EZ06wBZ+plzkGwVlITqMCDJY22XnP6cYRZLFbOR3ihw45gKavJcYwqMkxmm7BbFghe+JU/9aRxVgqeUEMLKC/jbL15z6wxxNW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052809; c=relaxed/simple;
	bh=+gMJzooNARvw2e0xhnqYaNuQPV+f/gPimN+Y24GZ6GU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Mq5P7n4eKURf931cfjJiKZyPp03IsjWH8e+/82d16HZboJ2N6qrSmQaJRJfB6WnV81B2uZkDayrxubtIrqXQ15JYsfkdt4b/2YjBv8nrNAv/qoBcHx2gZx5WE0O28Np1NNTpkpN1LkA+e8C9N33UM0gVJzy+mccddCNdSCBsLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24EE924000C;
	Tue, 27 Feb 2024 16:53:22 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peter@korsgaard.com>)
	id 1rf0hm-00GAei-0Z;
	Tue, 27 Feb 2024 17:53:22 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  netdev@vger.kernel.org,  linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: dm9601: fix wrong return value in
 dm9601_mdio_read
References: <20240225-dm9601_ret_err-v1-1-02c1d959ea59@gmail.com>
Date: Tue, 27 Feb 2024 17:53:22 +0100
In-Reply-To: <20240225-dm9601_ret_err-v1-1-02c1d959ea59@gmail.com> (Javier
	Carrasco's message of "Sun, 25 Feb 2024 00:20:06 +0100")
Message-ID: <874jdtsvb1.fsf@48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: peter@korsgaard.com

>>>>> "Javier" == Javier Carrasco <javier.carrasco.cruz@gmail.com> writes:

 > The MII code does not check the return value of mdio_read (among
 > others), and therefore no error code should be sent. A previous fix to
 > the use of an uninitialized variable propagates negative error codes,
 > that might lead to wrong operations by the MII library.

 > An example of such issues is the use of mii_nway_restart by the dm9601
 > driver. The mii_nway_restart function does not check the value returned
 > by mdio_read, which in this case might be a negative number which could
 > contain the exact bit the function checks (BMCR_ANENABLE = 0x1000).

 > Return zero in case of error, as it is common practice in users of
 > mdio_read to avoid wrong uses of the return value.

 > Fixes: 8f8abb863fa5 ("net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read")
 > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard

