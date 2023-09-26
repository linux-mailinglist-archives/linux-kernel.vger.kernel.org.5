Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45BA7AF589
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjIZUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjIZUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:50:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243F9F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:50:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68ABC433C8;
        Tue, 26 Sep 2023 20:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695761403;
        bh=3JVXHD4B9lMQRBYG5Ho/Z5uxFJWNJxBVMuf0sevF2J4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RWRsX3qiHSw6hR4nQ9wbTQVNU0jSRV+75d5aaO/jzTRu8c5lur3hZ2UzAZDoFIiNZ
         zpuFiT9MT9ftLv2uzzpMc+mc1DTI8o2AKeS5qBOS544wlV9tjy1af8BQzBAlzCTu8z
         /6fqkgwwz4jw0WHOV3Un5z31k/rNg/YUT4s/IYRA=
Date:   Tue, 26 Sep 2023 13:50:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        eric.devolder@oracle.com, vschneid@redhat.com,
        sourabhjain@linux.ibm.com
Subject: Re: [PATCH v3] Crash: add lock to serialize crash hotplug handling
Message-Id: <20230926135001.4eb6ca73b1a4aa6224355ad1@linux-foundation.org>
In-Reply-To: <20230926120905.392903-1-bhe@redhat.com>
References: <20230926120905.392903-1-bhe@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 20:09:05 +0800 Baoquan He <bhe@redhat.com> wrote:

> Eric reported that handling corresponding crash hotplug event can be
> failed easily when many memory hotplug event are notified in a short
> period. They failed because failing to take __kexec_lock.

I'm assuming that this failure is sufficiently likely so as to  justify a -stable
backport of the fix.   Please let me know if this is incorrect.
