Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ABE76B4CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjHAMb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjHAMb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:31:56 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E051FC6;
        Tue,  1 Aug 2023 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O5BpbWyfcEEuwF+JAY8ZIieV4+oN3raF7W0DkD+op+0=; b=Yf335vIUTDg0kFiXcYLf0LDUwV
        j2hLT+EGGETDCWjACzUUvktloFPJ0zsbciVjHsPIOjYlWuEvfLEouaUvvoQP+OQ0fVmyT5w4KGzq8
        RM/H21+9gDq7/1VH53ZVJhe+uiBxT8Oh9XeKYDYo4/f79r63TgvouXZqvlxIJ0GqRW6WmHAUU1oUs
        9k1Up5jOYud3NGwqUGTLpgc3mYs8UOqa7m6qi8QkmU0ZGNs/P37Q04papAO2qgDaC9tLPmOyTstxR
        5SElIkb/nte+vuNQvPg+2nNIrV40SWEkR2GWideULbchY13MQUYfPLGQv/gtdyFPmDljv8TCwUvZD
        lXLZgClw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41504)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qQoXR-00044N-1s;
        Tue, 01 Aug 2023 13:31:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qQoXR-0000gq-KG; Tue, 01 Aug 2023 13:31:45 +0100
Date:   Tue, 1 Aug 2023 13:31:45 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marcin Wojtas <mw@semihalf.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 8/8] net-next: mvpp2: don't shadow error
Message-ID: <ZMj7MRMkcEnhNnS9@shell.armlinux.org.uk>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
 <8c5b976a4ef9ba38fc952e9cf61848baa3e9dfe7.1690890774.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c5b976a4ef9ba38fc952e9cf61848baa3e9dfe7.1690890774.git.mazziesaccount@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:04:40PM +0300, Matti Vaittinen wrote:
> Do not overwrite error from lower layers but return the actual error to
> user if obtaining an IRQ fails.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Since your previous patch is incorrect, this one is too.

NAK.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
