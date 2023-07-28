Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F9766E72
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjG1Nad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjG1Na3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:30:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50594223;
        Fri, 28 Jul 2023 06:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6809C6214B;
        Fri, 28 Jul 2023 13:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0487BC433C7;
        Fri, 28 Jul 2023 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690550974;
        bh=H1KxPv9liKslrEFQ6KOnxzIeg0r307dT4AOwFkXnF8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SA16qhdeX2+kBzdZo4/NeNaah/dDkwYEtpl+vjFq+t4ajHikW0CB3z2XKw66z5mFK
         BOHICBsU6F/gz6aIFCZvQtGqgqrvVkwmJqXHPz3++NMxmhQrkFfsp7DAC7BCXlqRPR
         MJOiKVtwOkcRpJ9OgNB6EDV5TYgFiwkhuxlRk08P/DVpzfbkDj34aktIytdbGtt/p4
         W+KZanyy0wIJI+aQ32vkXAf9ySHDqN4IoQtnZmguF2Xg4gv7WtKMh3sDIeVnS5BMvH
         PjHryNiN/Ezn2ediJj2uF/+3L28Q0D8J0KPrtIFNJ1aU1U4CtPb/l1YK0m+0aGnCxq
         XCKPIlEbtKMtA==
Date:   Fri, 28 Jul 2023 14:29:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 0/4] perf: ampere: Add support for Ampere SoC PMUs
Message-ID: <20230728132928.GB21394@willie-the-truck>
References: <20230714010141.824226-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714010141.824226-1-ilkka@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 06:01:37PM -0700, Ilkka Koskinen wrote:
> Changes since v4:
>     * "Support implementation specific filters" patch:
>         - Added comment about filter and impdef registers and reference
>           to the Coresight PMU specification to the commit message
> 
>     * "Add support for Ampere SoC PMU" patch:
> 	- Fixed the documentation and added more comments
>         - Changed the incrementing PMU index number to idr_alloc()
> 	  (Needs a impdef release hook patch to release unused index)
> 	- Fixed style in init_ops() to more reasonable
> 	- Moved bank parameter to config1

This looks pretty good to me, but I think we should merge the series
reworking the backend registration first:

  https://lore.kernel.org/all/20230705104745.52255-1-bwicaksono@nvidia.com/

and then this should slot in quite nicely. I've left a minor comment over
there and I'd like Suzuki's review, but then we're good to go.

Cheers,

Will
