Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221B47ED298
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjKOUmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbjKOTzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:55:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A125D51
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:55:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7071C43391;
        Wed, 15 Nov 2023 19:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700078131;
        bh=IOan1DViLVGL6648KKxdL6vpXPpwQ8TXSgTEa52BCw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtD7unuSS0BM5OxTbsi5PQ2oE9yibweiJQFHhx+95WoD1oZOw6+VGGm5uNa5RvI5T
         Gip+8YO45FV1XbWkPc4Y4EHHg43w87aregHWAxP9+XJ7jfpB7ZOaw57oHOMzOmDbaj
         5ZgwODMh3JPJ9ZS+P75rmNqdvuPvK21gJmTXEfyqas82F0PMqpQ3/Kbsn/0cogj7WF
         lMUkGgFPp/mO0tI5GzVOtiV42Eplf4tdYYoLo8wknoFPHTjJfqKATT2YI1JMwWGZAn
         CPVK+HYl7WkWKySRlAEvABXBDkYAkEi3N7bqKWxlXvapqoNt8xNutsOYvumgdHbXoT
         hraZsf+aIK7bA==
Date:   Wed, 15 Nov 2023 14:55:26 -0500
From:   Keith Busch <kbusch@kernel.org>
To:     Yuanyuan Zhong <yzhong@purestorage.com>
Cc:     Jens Axboe <axboe@kernel.dk>, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        randyj@purestorage.com, hcoutinho@purestorage.com
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Message-ID: <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
 <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:21:53AM -0800, Yuanyuan Zhong wrote:
> On Wed, Nov 15, 2023 at 11:02 AM Jens Axboe <axboe@kernel.dk> wrote:
> 
> Do you mean something like this? If not, can you please elaborate
> "when we need"?
> -               struct nvme_effects_log *cel = xa_load(&ctrl->cels, ns->head->ids.csi);
> +               struct nvme_effects_log *cel = (ns->head->ids.csi == NVME_CSI_NVM) ?
> +                       ctrl->effects : xa_load(&ctrl->cels, ns->head->ids.csi);
> Will it be good to change ctrl->effects to ctrl->effects[3] for
> already defined CSI?

I suggest either re-assign the cached head->effects to one from a still
live controller when current path is removed, or move the saved effects
to the subsystem instead of the controller. All controllers in the
subsystem should be reporting the same effects log anyway, so
duplicating all that per-controller is kind of wasteful.
