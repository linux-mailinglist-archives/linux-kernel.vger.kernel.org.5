Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1E77818F0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjHSKla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjHSKlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C3435C32;
        Sat, 19 Aug 2023 02:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D5F2611EA;
        Sat, 19 Aug 2023 09:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62850C433C7;
        Sat, 19 Aug 2023 09:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692438996;
        bh=Rps3KvxSKq8mZbw1rmzGtX75tk7g8WkEG5Sk+oJzTN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIZ0aBTjhBx9fusJM2u6KWtYELKsGzcmygd3GnzKCFSVW8k0tHHTPiLZAbl7VTO9k
         NjxrwO0Z6gfQ1Z+oJmo+/PJ4+cqmvX2nbn8AXgOgqiIxaxWiXpoKRwuoyfwDAGZl5q
         53jguzZ4hqHkFIFQaIMm/NJvtJzqCfITdQyIEpnY=
Date:   Sat, 19 Aug 2023 11:56:33 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9?= Javier 
        <JoseJavier.Rodriguez@duagon.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: Re: [PATCH v2 1/1] mcb: create dedicated bus_type for mcb_bus and
 mcb_device
Message-ID: <2023081913-trifocals-flagpole-cdf7@gregkh>
References: <2023071044-deduct-cycle-a918@gregkh>
 <20230818110230.186700-1-JoseJavier.Rodriguez@duagon.com>
 <20230818110230.186700-2-JoseJavier.Rodriguez@duagon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818110230.186700-2-JoseJavier.Rodriguez@duagon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:03:03AM +0000, Rodríguez Barbarin, José Javier wrote:
> When allocating a new mcb_bus the bus_type is added to the mcb_bus
> itself, causing an issue when calling mcb_bus_add_devices().
> This function is not only called for each mcb_device under the
> mcb_bus but for the bus itself.
> 
> This causes a crash when freeing the ida resources as the bus numbering
> gets corrupted due to a wrong cast of structs mcb_bus and mcb_device.

Why not just fix this up and determine the "type" of the device before
you cast anything?

> Make the release of the mcb devices and their mcb bus explicit.

That's good, but now you have a new bus type which is a bit odd just for
the bus controller.  It's not necessarily bad, but not generally what
other busses do.  As an example, USB controllers are not their own bus
type, but rather, a different type of device on the same bus.  Same goes
for greybus devices/controllers.

So perhaps try doing that instead of creating a whole new bus here?

thanks,

greg k-h
