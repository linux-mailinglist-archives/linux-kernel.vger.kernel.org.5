Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79075750EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjGLQlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjGLQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF1E139;
        Wed, 12 Jul 2023 09:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E086182F;
        Wed, 12 Jul 2023 16:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE23C433C7;
        Wed, 12 Jul 2023 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689180070;
        bh=CzEOfSZpr9CSlURf6noLKDDczuEh/Yb9kBrx+k6k/KI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mFzSIXgBQdwprjB+KjUD4IN5TWV9YFyqtSB/toR7wO7nqI62FiHojknXUSYE8pzC7
         7UfkyJSy+EZbQRhI1sv3RUh5L0iop3zoX14bHnUmJkf/4t9Zsc16vGmVps0m3EnGCz
         GzYT3m4p7e8x496G1QmmGqFWFlwg8/p1ONG1BTF8=
Date:   Wed, 12 Jul 2023 18:41:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V1 1/3] usb: misc: Add the interface for notifier call
 for Embedded USB Debugger(EUD)
Message-ID: <2023071259-stumbling-collected-9c59@gregkh>
References: <cover.1689148711.git.quic_schowdhu@quicinc.com>
 <a2b04d69396c9522327f6c0f22637a83161a5fe9.1689148711.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b04d69396c9522327f6c0f22637a83161a5fe9.1689148711.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 01:52:38PM +0530, Souradeep Chowdhury wrote:
> Add the interface for notifier calls that can be made to check the role
> switch status of EUD. An external module can import this file and use the
> wrapper functions eud_register_notify to register a notifier to the EUD
> notifier chain, eud_unregister_notify to unregister the notifier from the
> chain, eud_notifier_call_chain to call the notifier chain to check the
> status of role-switch. These interfaces are provided to handle the case
> where multiple modules might go for a role-switch on the same port in which
> case EUD will be given priority over the rest.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  drivers/usb/misc/qcom_eud_notifier.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 drivers/usb/misc/qcom_eud_notifier.h
> 
> diff --git a/drivers/usb/misc/qcom_eud_notifier.h b/drivers/usb/misc/qcom_eud_notifier.h
> new file mode 100644
> index 000000000000..0cae42a5f6bf
> --- /dev/null
> +++ b/drivers/usb/misc/qcom_eud_notifier.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Released under the GPLv2 only.
> + */
> +
> +#include <linux/notifier.h>
> +
> +extern int eud_register_notify(struct notifier_block *nb);
> +extern void eud_unregister_notify(struct notifier_block *nb);
> +extern void eud_notifier_call_chain(unsigned long role_switch_state);
> -- 
> 2.17.1
> 

Don't add .h files that no one actually use.
