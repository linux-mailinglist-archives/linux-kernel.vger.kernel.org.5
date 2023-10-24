Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EEB7D53A5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbjJXOHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjJXOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:07:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259DA3;
        Tue, 24 Oct 2023 07:07:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A78C433C8;
        Tue, 24 Oct 2023 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698156462;
        bh=9jC8oNZgHX1Zi6aWIvKR5WIBscBYWtT/XNF7Ji+UiB8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gXC+envN88pZ16F8KzAjczjiWBqEKfHwpJD0p7P+wmzdB+o7NwKEiLXAFTNwGw/1g
         dieOYHrquj917Fj/nh2ar4Oc8Wj2kFU+RX8UHAM2mzCoTWHtvOteXl2tsuuLYEvOpV
         vhzNHq5eF96otmpUqWODLhOHYs0IfVbpKVmsjrwylxLKKgTAk8QVJUarSBxggH+LZv
         9i00MapnXdOhEsMDCibsxQUOp13U/KyXxxJWIPHsUoJ3lwq3tzXcjuLzexDz/vbXRK
         Si+n9xhtkO/wslDcK+pBQlm2SmySgNzvQuF0myT1gavca1fWMSqLJOW2UX0A4RLgpj
         fctl56uXy/gww==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] wifi: ath11k: fix event locking
References: <20231019153115.26401-1-johan+linaro@kernel.org>
Date:   Tue, 24 Oct 2023 17:07:38 +0300
In-Reply-To: <20231019153115.26401-1-johan+linaro@kernel.org> (Johan Hovold's
        message of "Thu, 19 Oct 2023 17:31:13 +0200")
Message-ID: <87o7goxget.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan+linaro@kernel.org> writes:

> RCU lockdep reported suspicious RCU usage when accessing the temperature
> sensor. Inspection revealed that the DFS radar event code was also
> missing the required RCU read-side critical section marking.
>
> Johan
>
>
> Changes in v2
>  - add the missing rcu_read_unlock() to an
>    ath11k_wmi_pdev_temperature_event() error path as noticed by Jeff
>
>
> Johan Hovold (2):
>   wifi: ath11k: fix temperature event locking
>   wifi: ath11k: fix dfs radar event locking

Thanks for the fixes. I really like using lockdep_assert_held() to
document if a function requires some lock held, is there anything
similar for RCU?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
