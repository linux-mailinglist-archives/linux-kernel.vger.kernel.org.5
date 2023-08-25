Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA6B788C84
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241614AbjHYPej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbjHYPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C472134;
        Fri, 25 Aug 2023 08:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7D064890;
        Fri, 25 Aug 2023 15:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25F3C433C8;
        Fri, 25 Aug 2023 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692977674;
        bh=iRLOoCwRJElGcZjOp6rXISnCKlfpriO8DTj22vK8d9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9FPPQJoLvxgfGjW2R7HSeQ2wlEV+BM1j9M8pOK0xRXIVIp3xRU3p/L5pAKn1irNv
         dgeo9Bh0pVFwJ98Miag6EF6y+1zG366MPHvGGO4xl3ROqxq5i7kXmRL0P1pCdNv+k3
         517aoT4/lYz4nj+YkFELwQYKCf9SIYAXVtJjp2zo=
Date:   Fri, 25 Aug 2023 17:34:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: shrink the size of struct tty_struct by 40 bytes
Message-ID: <2023082531-daylight-vitally-fcb3@gregkh>
References: <2023082519-cobbler-unholy-8d1f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082519-cobbler-unholy-8d1f@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 05:28:20PM +0200, Greg Kroah-Hartman wrote:
>  	bool hw_stopped;
> -	unsigned int receive_room;
> +	bool closing;
>  	int flow_change;

Note, "flow_change" really only has 2 values, 1 or 2, so it could be a
boolean, or a u8 at the worse (both take the same amount of space).  But
changing that here doesn't affect the overall size of the structure,
just increases the hole at this location in the structure, so it's not a
big deal at this point in time.

thanks,

greg k-h
