Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32C678F2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbjHaSyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbjHaSyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:54:00 -0400
Received: from mail.gnu-linux.rocks (unknown [82.165.184.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D28AE64;
        Thu, 31 Aug 2023 11:53:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [95.91.250.92])
        by mail.gnu-linux.rocks (Postfix) with ESMTPSA id 662ED3FC1A;
        Thu, 31 Aug 2023 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnu-linux.rocks;
        s=mail; t=1693508034;
        bh=7imahw4z5cLGzUlIZ+ONUMGcCu5zD8w6Z7f3ADNu7oY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejaoxn2g9e4y1GSPm1RlGBOCiwj7I4V+d2wGzwbvUkP50WHgOLMIYNTfHJjXGGSyU
         H9DxxrqCPbOOZ/QUwg/ZIpgn83vcPSGopaBdrWUB4IQrg8Cb+mpReIG2RR1lhAscLV
         jCKz6B88eQuXetUlVO4ffw2TYCKqhY5Z6uZGBZXXjKdbbIRHEeWNo4jbSVCIXFxsu4
         20KxmmOrb404v5fkA1AW50gkZsZxLUPCdSiq1alpeldB78AWW6eAv3FKvWWVFPTu3X
         SxnQdR25Qqni7hYOZTtDWxF6F+91GUSJQRE7nzByT950OldHZ1bQleX1revd7mnCdk
         cbfmzlLXBCIPg==
From:   Johannes Roith <johannes@gnu-linux.rocks>
To:     sergeantsagara@protonmail.com
Cc:     ak@it-klinger.de, andi.shyti@kernel.org,
        benjamin.tissoires@redhat.com, christophe.jaillet@wanadoo.fr,
        jikos@kernel.org, johannes@gnu-linux.rocks,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v5] hid-mcp2200: added driver for GPIOs of MCP2200
Date:   Thu, 31 Aug 2023 20:53:43 +0200
Message-ID: <20230831185343.211651-1-johannes@gnu-linux.rocks>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <87a5unt25h.fsf@protonmail.com>
References: <87a5unt25h.fsf@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

thanks for the feedback, I will add it to the driver.

> My personal recommendation is to just have a single DMA buffer allocated
> for the mcp2200 instance rather than having to call the allocator and
> release the memory per command.

I added an 16-byte Array hid_report to the mcp2000 struct. When I need the
report, I do the following:

struct mcp_set_clear_outputs *cmd;

mutex_lock(&mcp->lock);
cmd = (struct mcp_set_clear_outputs *) mcp->hid_report

Do you think this is a valid implementation or do I really have to add a
pointer to the mcp2200 struct instead of the 16 byte array and allocate 
another 16 byte for it in the probe function?

> The reason you run into this is likely because of the action added to
> devm conflicting with hid_device_remove....
> 
> I recommend not depending on devm for teardown rather than making a stub
> remove function to work around the issue.

I am not sure, if I have understand this correctly, but basically I already
have a stub remove function (which is empty). First the remove function gets
called, then the unregister function and everything is cleaned up correctly.
Did I get this right or do you have any other recommendation for me?

So, do I need any adaptions, or can we go with the empty remove function?

Best regards,
Johannes
