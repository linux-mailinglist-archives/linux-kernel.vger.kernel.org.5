Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4223C7F6C31
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjKXGPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXGPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:15:15 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09EAD6F;
        Thu, 23 Nov 2023 22:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iitzqEcqy2/NvHpJVilvHrDiSq6ioct471RtcAQWPEc=; b=RLknA5n6GG7PuJuFB/06MrnTp5
        K9hmIcs/BPIcg4G6vog2iZx2aNKOQgUTSGSbk0pcleHaJ7d7t/7B5FRcyRHynMjvzWTKe2i6JdEOm
        9IqomBGGvJA89OOvgrEimkS/GYCWd0ORsUE2+HZLzeJYWxZQXhgCz3D8XDcjSK0kD2e467a/3p8S1
        00+I2xUzkUGIcW+OI38iiIT1ibkJjuM3mLvbkBJ2Zxr3I0tZATM5y1V3g/cIsOfIJuJigZ74Taj6y
        c4fV3B8tsVQVt1dLi76J0NmYEEl3gG6PZTIK06g7Z6IizA2nQIjxkjxghs/feEyc7FtZbP/KdANep
        vO2vZqqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PTC-002QBO-37;
        Fri, 24 Nov 2023 06:15:19 +0000
Date:   Fri, 24 Nov 2023 06:15:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mo Zou <lostzoumo@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] rename(): avoid a deadlock in the case of parents
 having no common ancestor
Message-ID: <20231124061518.GS38156@ZenIV>
References: <20231122193028.GE38156@ZenIV>
 <20231122193652.419091-1-viro@zeniv.linux.org.uk>
 <20231122193652.419091-9-viro@zeniv.linux.org.uk>
 <20231123103622.4mfjwrmxr4tl53hi@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123103622.4mfjwrmxr4tl53hi@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:36:22AM +0100, Jan Kara wrote:

> It would look more natural to me if s_vfs_rename_mutex got dropped in the
> callers (lock_rename(), lock_rename_child()) which have acquired the lock
> instead of here. I agree it results in a bit more boiler plate code though.

finish_locking_two_parents(), perhaps? ;-)

Seriously, though - it starts with ->s_vfs_rename_mutex and ends with
the environment for vfs_rename() or with all locks dropped.
