Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDEE7D496C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjJXIKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjJXIKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:10:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A331A4;
        Tue, 24 Oct 2023 01:10:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC23C433C8;
        Tue, 24 Oct 2023 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698135020;
        bh=5xhUOdK0houexRKXcOj94zVlL2PpAocoXIRj8TfVKBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KG5T8Mq204F7Y8wCR8YhBSH8HQhdygp9fDkcBf8ZbjAsamSjwbx9XVKJUTxcVpUKH
         cgiqTFb8Et2+yKm7cGxUrh6kHKpQCi3p68Yb89KSDvvM0OKF/3L3OLYEfDvzJupvFi
         /BrbMIvLz6iAAboqli2ryXqpYg2mCto1wk/3RNw4=
Date:   Tue, 24 Oct 2023 10:10:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] tty: serial: 8250: Add support for MOXA PCIe
 boards to switch interface between RS422/RS485
Message-ID: <2023102403-clash-utmost-8377@gregkh>
References: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
 <20231018091739.10125-7-crescentcy.hsieh@moxa.com>
 <f49feb43-e255-43bb-4271-8a13db2859fc@linux.intel.com>
 <ZTd2t9nsBx9pZKD9@moxa-ThinkCentre-M90t>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTd2t9nsBx9pZKD9@moxa-ThinkCentre-M90t>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 03:48:07PM +0800, Crescent CY Hsieh wrote:
> On Mon, Oct 23, 2023 at 12:25:18PM +0300, Ilpo Järvinen wrote:
> > On Wed, 18 Oct 2023, Crescent CY Hsieh wrote:
> > > +		/*
> > > +		 * RS232 is not supported for MOXA PCIe boards with device IDs
> > > +		 * matching the pattern 0x*3**.
> > > +		 */
> > > +		if (pci_moxa_match_second_digit(device, 0x0300))
> > > +			return -EOPNOTSUPP;
> > 
> > This is not the correct error code I think. Maybe return -ENXIO instead.
> 
> I think EOPNOTSUPP or ENOTSUPP would be more reasonable, they directly
> indicates "operation is not supported".
> 
> However, EOPNOTSUPP is used for network-related and ENOTSUPP is used for
> NFSv3 protocol, even though they are already been used throughout the
> kernel.
> 
> Maybe add a new one stand for serial, or clean them up into a general
> one, or use EOPNOTSUPP and ENOTSUPP just for now?

-ENODEV should be the proper one here.

thanks,

greg k-h
