Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5993F7C9561
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjJNQbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjJNQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:31:29 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135FB7;
        Sat, 14 Oct 2023 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=THW6nJ2E4AHZv1MDVtsblWf1vbWublGZsqD9188DwRQ=; b=2M5x3pC1mi007B7pI4y7wNG/un
        A1lastkRpMyrGbf3qUyYHJTvyTclWO0y1uI+gDzqvhwxHe/1GML/NHgwZXFSz22Uy+jtlymWPRuXn
        EoLmFOnO4bPYCIbab1hOci/DMstEoEvC3nhLI4SEK08YRYRvdzgVR94u2pvwQcyH34Fg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qrhXo-002Bdy-5p; Sat, 14 Oct 2023 18:31:16 +0200
Date:   Sat, 14 Oct 2023 18:31:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jiawen Wu <jiawenwu@trustnetic.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: txgbe: replace deprecated strncpy with strscpy
Message-ID: <1c0e94ff-617b-4672-addb-8933f92edc29@lunn.ch>
References: <20231012-strncpy-drivers-net-ethernet-wangxun-txgbe-txgbe_main-c-v1-1-c9bb3270ac98@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-wangxun-txgbe-txgbe_main-c-v1-1-c9bb3270ac98@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 09:20:04PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Based on usage part_str usage within txgbe_read_pba_string(), we expect
> part_str to be NUL-terminated but not necessarily NUL-padded:
> |       /* put a null character on the end of our string */
> |       pba_num[10] = '\0';
> 
> Interestingly, part_str is not used after txgbe_read_pba_string():
> | ...
> |	err = txgbe_read_pba_string(wx, part_str, TXGBE_PBANUM_LENGTH);
> |	if (err)
> |		strscpy(part_str, "Unknown", sizeof(part_str));
> |
> |	netif_info(wx, probe, netdev, "%pM\n", netdev->dev_addr);
> |
> |	return 0;
> |
> |err_remove_phy:
> |	txgbe_remove_phy(txgbe);
> |err_release_hw:
> |	wx_clear_interrupt_scheme(wx);
> |	wx_control_hw(wx, false);
> |err_free_mac_table:
> |	kfree(wx->mac_table);
> |err_pci_release_regions:
> |	pci_release_selected_regions(pdev,
> |				     pci_select_bars(pdev, IORESOURCE_MEM));
> |err_pci_disable_dev:
> |	pci_disable_device(pdev);
> |	return err;
> |}
> ... this means this strncpy (or now strscpy) is probably useless. For
> now, let's make the swap to strscpy() as I am not sure if this is truly
> dead code or not.

Hi Julian

I agree, this looks like dead code.

Jiawen, please could you submit a patch cleaning this up. Either swap
to strscpy() and make use of the string, or delete it all.


    Andrew

---
pw-bot: cr
