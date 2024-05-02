Return-Path: <linux-kernel+bounces-166055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCA58B954D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDDBB2199C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B8224F2;
	Thu,  2 May 2024 07:30:56 +0000 (UTC)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F04521A04
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635055; cv=none; b=ULRVAkPzTsiG63+fLs1R47Q0hbLoLl6Xc+raW6Uugh7/sLPCeGNibDwNkK7/+dk9j940Xh42PTXmisHwohqYXDViYSdRjog3TPOs++7xGfpmRFIT/1gfkhNNNUFw3eyC8tpnwf9O/Z4jrLlrlIABB8r6q1PqGJfI1iQbawZMgBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635055; c=relaxed/simple;
	bh=1M8PYJnBXnW/oj67wWmDLahjkn2KzyAvAS1go61CQVk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9BREs4K49BTM34GMUGlC5nemx+GR6JzT7ctWSRknMiFykSv9JX7P1sC+dTctyo7cawZ066Hqo+TyOwCkqVMgPHlrVdvroG4rbXSd9fB8FUXieHadcpPH7/7cnLY3OKmTWe3XG0jw3kGR4qEFcGsmdrTFfBgwj6aO5tU2dmBWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3367342:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 02 May 2024 15:30:29 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 May 2024
 15:30:29 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 2 May 2024 15:30:29 +0800
Date: Thu, 2 May 2024 15:30:29 +0800
From: Alina Yu <alina_yu@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <20240502073029.GA4055@linuxcarl2.richtek.com>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
 <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 01, 2024 at 11:19:05AM +0900, Mark Brown wrote:
> On Tue, Apr 30, 2024 at 05:58:25PM +0800, Alina Yu wrote:
> 
> > In this patch, LDO's adjustable and fixed Vout settings are compatible.
> > The LDO Vout ability depends on the init_data->constraints.
> > If adjustable, the Vout can be set to either 1800mV or 3300mV.
> 
> > +		if (init_data->constraints.min_uV == init_data->constraints.max_uV) {
> > +			desc->n_voltages = 1;
> > +			desc->fixed_uV = init_data->constraints.min_uV;
> > +			desc->ops = &rtq2208_regulator_ldo_fix_ops;
> > +		} else {
> > +			desc->n_voltages = ARRAY_SIZE(rtq2208_ldo_volt_table);
> > +			desc->volt_table = rtq2208_ldo_volt_table;
> > +			desc->ops = &rtq2208_regulator_ldo_adj_ops;
> > +		}
> 
> Why are you making this change?  The operations supported by the
> regulator don't change depending on if the system is going to chnage the
> voltage.

The change is necessary due to the requirement of the SD card for high/default and ultra-high-speed modes. The system needs to adjust the LDO Vout accordingly.
In ultra-high-speed mode, the LDO Vout needs to be adjusted to 1.8V; otherwise, it will remain at 1.8V.


Thanks,
Alina



