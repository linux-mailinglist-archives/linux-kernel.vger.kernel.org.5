Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B061777BA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjHNNg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjHNNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:36:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C0CE77;
        Mon, 14 Aug 2023 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692020166; x=1723556166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3NPomn0odXdkCgTnehQAmG1OPmJu6qGkPr3+iNl2dtg=;
  b=Egp9s3nCim8YEnzlR6YmGNQ85bKdhyqL2yobH0yDoYf43f12IQkOj4Yp
   P5XL/RRaCR/XKZi/74D5vBqTB8dRolASTM+ATH9btjOOgt0QzUozGnHY3
   wj7hA3vP1wrBvoYkEg7QN5JtdWzcsVFnPLi4uHcajeJoyczZbDrj3HQxY
   trWDCRmxWGHhKJkznvtEw0Wk4uSZ+OaHBJrs4iegG6ktWk4WPucVUdZkC
   XeFaQL+zvRCveGaDoKj9NnKOWLkHwyXAcBSRbdKzWDPZirlp2Ze3esRW2
   Dr8Nb1b/6ojVWI06gOqiYZgygTlB733URRVkuEJ0ZP1lvw9+WbVEonWHm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="352366504"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="352366504"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 06:36:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="876943141"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Aug 2023 06:36:06 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 14 Aug 2023 16:36:02 +0300
Date:   Mon, 14 Aug 2023 16:36:02 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     RD Babiera <rdbabiera@google.com>
Cc:     gregkh@linuxfoundation.org, linux@roeck-us.net, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: bus: verify partner exists in
 typec_altmode_attention
Message-ID: <ZNotwo3tRWMZta4u@kuha.fi.intel.com>
References: <20230811213732.3325896-1-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811213732.3325896-1-rdbabiera@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 09:37:32PM +0000, RD Babiera wrote:
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5a7d8cc04628..97b7b22e9cf1 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1791,6 +1791,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  	u32 p[PD_MAX_PAYLOAD];
>  	u32 response[8] = { };
>  	int i, rlen = 0;
> +	int ret;
>  
>  	for (i = 0; i < cnt; i++)
>  		p[i] = le32_to_cpu(payload[i]);
> @@ -1877,7 +1878,9 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  			}
>  			break;
>  		case ADEV_ATTENTION:
> -			typec_altmode_attention(adev, p[1]);
> +			ret = typec_altmode_attention(adev, p[1]);
> +			if (ret)
> +				tcpm_log(port, "typec_altmode_attention NULL port partner altmode");

I don't think you need that ret variable:

                        if (typec_altmode_attention(adev, p[1]))
				tcpm_log(port, "typec_altmode_attention NULL port partner altmode");

>  			break;
>  		}
>  	}

thanks,

-- 
heikki
