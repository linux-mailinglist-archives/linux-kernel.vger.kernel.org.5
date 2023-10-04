Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2AD7B8DCC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243953AbjJDUCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjJDUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:02:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B2DAD;
        Wed,  4 Oct 2023 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MEDpCLtA6saV273n9QbcI2SdIbI0BMgImtkzhlafRjs=; b=haqQaiCbgNfx9MLqPT6W8jhO7K
        JEVhl8TGbPhoNHqFMYUrjcD63PDSQ7/zJO48daapSPsR3Q6xIXyPnvOh8YJHtokW/xl0mzstSwvKt
        YTjl/M4/Hk5mT8JntCjGewR+Ggny35NWm15L8cGiT0HiIy/c2e9zIvyqtx/Tj3K7G10Pzbprb8vjx
        xzpLmF0K8jfh+ETxNPuME7H9XiK4+kZmAgZUCQtCT3i3lZMdk4ruZp4DbL1e93j2/JrAIpk5mYKNP
        kIwGBryenk63kLXf0pUHpd4TtRiwkk8zusr6mMYtPf1qIfTxY8DXTfcSwbo7qcPU0oFmOrxVLsQOX
        lzv3l5pg==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qo84m-00Fp66-0x;
        Wed, 04 Oct 2023 20:02:32 +0000
Date:   Wed, 4 Oct 2023 13:02:29 -0700
From:   Joel Becker <jlbec@evilplan.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: Re: [PATCH 2/3] netconsole: Attach cmdline target to dynamic target
Message-ID: <ZR3E1TLE+BFuctsx@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>, kuba@kernel.org,
        davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
References: <20231002155349.2032826-1-leitao@debian.org>
 <20231002155349.2032826-3-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002155349.2032826-3-leitao@debian.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 08:53:48AM -0700, Breno Leitao wrote:
> Enable the attachment of a dynamic target to the target created during
> boot time. The boot-time targets are named as "cmdline\d", where "\d" is
> a number starting at 0.
> 
> If the user creates a dynamic target named "cmdline0", it will attach to
> the first target created at boot time (as defined in the
> `netconsole=...` command line argument). `cmdline1` will attach to the
> second target and so forth.
> 
> If there is no netconsole target created at boot time, then, the target
> name could be reused.
> 
> Relevant design discussion:
> https://lore.kernel.org/all/ZRWRal5bW93px4km@gmail.com/
> 
> Suggested-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index b68456054a0c..6235f56dc652 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -685,6 +685,23 @@ static const struct config_item_type netconsole_target_type = {
>  	.ct_owner		= THIS_MODULE,
>  };
>  
> +static struct netconsole_target *find_cmdline_target(const char *name)
> +{
> +	struct netconsole_target *nt, *ret = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&target_list_lock, flags);
> +	list_for_each_entry(nt, &target_list, list) {
> +		if (!strcmp(nt->item.ci_name, name)) {
> +			ret = nt;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&target_list_lock, flags);
> +
> +	return ret;
> +}
> +
>  /*
>   * Group operations and type for netconsole_subsys.
>   */
> @@ -695,6 +712,13 @@ static struct config_item *make_netconsole_target(struct config_group *group,
>  	struct netconsole_target *nt;
>  	unsigned long flags;
>  
> +	/* Checking if there is a target created populated at boot time */

Perhaps a little clearer:

```
       /* Checking if a target by this name was created at boot time.  If so,
          attach a configfs entry to that target.  This enables dynamic
          control. */
```

> +	if (!strncmp(name, DEFAULT_TARGET_NAME, strlen(DEFAULT_TARGET_NAME))) {
> +		nt = find_cmdline_target(name);
> +		if (nt)
> +			return &nt->item;
> +	}
> +

Thanks,
Joel

-- 

Life's Little Instruction Book #356

	"Be there when people need you."

			http://www.jlbec.org/
			jlbec@evilplan.org
