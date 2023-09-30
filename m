Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA70F7B41F2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjI3QEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjI3QEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:04:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F5CBE
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 09:04:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144A7C433C7;
        Sat, 30 Sep 2023 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696089872;
        bh=6RkJeO80Y6I9k6A93GTmjkGFgNpYWb9OU4GsW1LTuYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RcJAsXbE9a5DeIf+W8MB19aWP172gjnpP3lwAuggEBDqnEKXAJwmYCG6ImDppINAY
         f6/q/GRNZ2e5Ma8pmzb2B888SrguU8F5MoxwHIILuAUfIaCRxLOdV9UcROOdH/OyQx
         Cn+HPqALEhFGILZADjo60ed3ulIpl8eQQ1lRFkVZyN2ATRTSV7LBXZcKSNsUeXTuoU
         w9Dm0ulg+qEGA6vJUKNqAp6xTPkBY8sPtIslKW+d8xslsUr+zOM7suKtKcH5CTdL8S
         Rn4qi5uI6q0Y85znGNOjKYdYHYj+9D4+HoHittc7tGLxOdd+/mPl+GIw571L1DCt5t
         xQ5G1AnDmR7dA==
Date:   Sat, 30 Sep 2023 18:04:28 +0200
From:   Simon Horman <horms@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     3chas3@gmail.com, davem@davemloft.net,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] atm: solos-pci: Fix potential deadlock on
 &cli_queue_lock and &tx_queue_lock
Message-ID: <20230930160428.GB92317@kernel.org>
References: <20230926104442.8684-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926104442.8684-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ David Woodhouse <dwmw2@infradead.org>

On Tue, Sep 26, 2023 at 10:44:42AM +0000, Chengfeng Ye wrote:
> As &card->cli_queue_lock and &card->tx_queue_lock are acquired under
> softirq context along the following call chain from solos_bh(), other
> acquisition of the same lock inside process context should disable
> at least bh to avoid double lock.
> 
> <deadlock #1>
> console_show()
> --> spin_lock(&card->cli_queue_lock)
> <interrupt>
>    --> solos_bh()
>    --> spin_lock(&card->cli_queue_lock)
> 
> <deadlock #2>
> pclose()
> --> spin_lock(&card->tx_queue_lock)
> <interrupt>
>    --> solos_bh()
>    --> fpga_tx()
>    --> spin_lock(&card->tx_queue_lock)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch uses spin_lock_irqsave()
> on the two locks under process context code consistently to prevent
> the possible deadlock scenario.

Hi Chengfeng Ye,

thanks for your patch.

As this patch seems to fix two, albeit, similar problems,
it should probably be split into two patches.

As fixes for Networking code they should probably be targeted at the
'net' tree. Which should be denoted in the subject.

	Subject: [PATCH net] ...

And as fixes the patch(es) should probably have Fixes tags.
These ones seem appropriate to me, but I could be wrong.

Fixes: 9c54004ea717 ("atm: Driver for Solos PCI ADSL2+ card.")
Fixes: 213e85d38912 ("solos-pci: clean up pclose() function")

> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>  drivers/atm/solos-pci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
> index 94fbc3abe60e..247e9200e312 100644
> --- a/drivers/atm/solos-pci.c
> +++ b/drivers/atm/solos-pci.c
> @@ -447,11 +447,12 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
>  	struct atm_dev *atmdev = container_of(dev, struct atm_dev, class_dev);
>  	struct solos_card *card = atmdev->dev_data;
>  	struct sk_buff *skb;
> +	unsigned long flags;
>  	unsigned int len;
>  
> -	spin_lock(&card->cli_queue_lock);
> +	spin_lock_irqsave(&card->cli_queue_lock, flags);
>  	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
> -	spin_unlock(&card->cli_queue_lock);
> +	spin_unlock_irqrestore(&card->cli_queue_lock, flags);
>  	if(skb == NULL)
>  		return sprintf(buf, "No data.\n");
>  
> @@ -954,16 +955,17 @@ static void pclose(struct atm_vcc *vcc)
>  	unsigned char port = SOLOS_CHAN(vcc->dev);
>  	struct sk_buff *skb, *tmpskb;
>  	struct pkt_hdr *header;
> +	unsigned long flags;
>  
>  	/* Remove any yet-to-be-transmitted packets from the pending queue */
> -	spin_lock(&card->tx_queue_lock);
> +	spin_lock_irqsave(&card->tx_queue_lock, flags);
>  	skb_queue_walk_safe(&card->tx_queue[port], skb, tmpskb) {
>  		if (SKB_CB(skb)->vcc == vcc) {
>  			skb_unlink(skb, &card->tx_queue[port]);
>  			solos_pop(vcc, skb);
>  		}
>  	}
> -	spin_unlock(&card->tx_queue_lock);
> +	spin_unlock_irqrestore(&card->tx_queue_lock, flags);
>  
>  	skb = alloc_skb(sizeof(*header), GFP_KERNEL);
>  	if (!skb) {
> -- 
> 2.17.1
> 
> 

-- 
pw-bot: changes-requested
