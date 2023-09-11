Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384A479C0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbjIKWGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244012AbjIKSlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:41:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B360C1AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:40:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B48EC433C9;
        Mon, 11 Sep 2023 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694457658;
        bh=KQWdx/Fl0YYS27pw8mW5NagTbUm9aANbYaGKwBbxMRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fjn3MsGes9YA8GWfL0TlxGW4rS6yrqd0+qvR+ILrrE7snCVKKbdDZTCSCcBTvjYz+
         DoElXtK16OBKquPLHS7B1SFDLvPEZ9KL3wD/FMv4bUA7P5TOnmCJJnVGVBs1YPfaEF
         1xs04pKLUTzfeZ6wO2aPKaM5sOmmpKieUNcSUz26eU1GQzFF2lI58iBnKcjJ9G+81k
         s07y3fThthSSr+BKkvOSUWmCAXrED0Dmn4yBKs++t4c5B6gl5DEj7TDEdfRiT3vnL8
         rgchc02OxVFYnZKZ9IJpnQPxBbBw32o4VtVqUyc9478Mpf1u1SqvrfOO+FPLKSETz+
         Llh7+5huQZafQ==
Date:   Mon, 11 Sep 2023 11:40:56 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ameer Hamza <ahamza@ixsystems.com>
Cc:     linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me, linux-kernel@vger.kernel.org, mav@ixsystems.com,
        edmund.nadolski@ixsystems.com
Subject: Re: [PATCH] nvme: prevent id ctrl csi for specs below 2.0
Message-ID: <ZP9fOBSl59u8u0hq@kbusch-mbp.dhcp.thefacebook.com>
References: <20230910212641.338438-1-ahamza@ixsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910212641.338438-1-ahamza@ixsystems.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 02:26:41AM +0500, Ameer Hamza wrote:
> The 'id ctrl csi' command was introduced in version 2.0, as specified
> in Section 5.17.2.6 of the NVME Base Specification 2.0. Executing this
> command on previous NVMe versions returns an "Invalid Field" error,
> and the error entry is saved in the log page. Although, Commit
> c917dd96fe41 ("nvme: skip optional id ctrl csi if it failed") reduced
> the error occurrences, but the error persisted during the initial
> module load. This patch ensures the command isn't executed on versions
> older than 2.0, and it also eliminates the skip implementation because
> NVME_ID_CNS_CS_CTRL is expected to succeed with version 2.0.

NVMe TP's are allowed to be implemented by versions lower than the
release that first included it. I recall the first nvme controller I'd
seen that implemented this identification reported itself as 1.4.
