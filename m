Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB13477D87E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbjHPCe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbjHPCeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:34:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861001FDF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21AF76218F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55073C433C8;
        Wed, 16 Aug 2023 02:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692153259;
        bh=ILKLaDUtT4i0mLelpGeGRXNq7uFDFZtIQuCu+6LzedM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuEwZD18a+rqpN6UCHqN06Yf4QFXzCf+Tf9BmBrmkdCIJIBCkmqCsmctg8RBclgVV
         eeJ+SYK6N9DCir13+XKXkYpNE2bQADoV0p/40qnnWkJHP36HH+HrbQ+bFVF9Fqgplx
         yHaAEud6GmX6qIiZUfKLdWRTaigIhI8lZHajJkH0voVHAqrsnVB8sVPdXSAvr74x6/
         Dgjv5w1tw8+EDOVn/ADghbjLDzGul6s0ijY+EliEvC9HwKzz4V/bPL+WTS5uWtBH3u
         qgVAdGdMYD0LNKeUrjsx5RUv+HnPyy/8Oz3mAc7KcT+dPzKz9dxem/5i4jwiECgZe/
         GhkZZCkJUUk5w==
Date:   Tue, 15 Aug 2023 19:34:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Add 16K Support for f2fs
Message-ID: <20230816023417.GA899@sol.localdomain>
References: <20230816011432.1966838-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816011432.1966838-1-drosen@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 06:14:31PM -0700, Daniel Rosenberg via Linux-f2fs-devel wrote:
> F2fs filesystems currently have two large restrictions around block size.
> The block size must equal the page size, and the block size must be 4096.
> 
> The following patch, along with the associated f2fs-tools patch set, relax the
> latter restriction, allowing you to use 16K block size f2fs on a 16K page size
> system. It does not allow mounting 4K block size f2fs on a 16k page system.
> 
> Doing that would require a lot more work, requiring a refactor of all block
> sized struct similar to the userspace patches, as well as handling the block
> reading/writing at sub page boundaries. As far as I know, buffer_heads are
> still the main way this is handled in other filesystems. Is there a different
> option there? I know there's a general desire to move away from buffer_heads,
> but I don't know of any replacements covering that use case. And it would feel
> a bit silly to not be able to read older filesystems from a 16k system...

iomap is the replacement for buffer heads.  See https://lwn.net/Articles/935934

- Eric
