Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC8680EF29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376937AbjLLOp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376962AbjLLOpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:45:36 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF91BDB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XJm1mbIOR30K1gTnKGUICHGzhhX6pGczga8Txr1Ex6w=;
  b=LMjlS2Zyas1H7mxEgqKmDA58Y1+Uh6ry4AE8o5ladFlkAy8N+dCYty6g
   qRpTJqhPvVXcTfwOgtOKczjAv43jI+VLC7t4jijXapFWH9v5wHfRfmiG+
   AeZO1YYd3hCJC4tUc0pKBLdqpL6ELgWX27RbyjHgGPPCOwu1zt38lXfnN
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,270,1695679200"; 
   d="scan'208";a="141848225"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:44:49 +0100
Date:   Tue, 12 Dec 2023 15:44:49 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Ivan Vecera <ivecera@redhat.com>
cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Failed to start Raise network interfaces error
In-Reply-To: <alpine.DEB.2.22.394.2312102317350.3198@hadrien>
Message-ID: <492e8f8-c7af-7423-59e6-348ce5fca9b1@inria.fr>
References: <alpine.DEB.2.22.394.2312102317350.3198@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Dec 2023, Julia Lawall wrote:

> Hello,
>
> Starting with the commit:
>
> commit 9e479d64dc58f11792f638ea2e8eff3304edaabf
> Author: Ivan Vecera <ivecera@redhat.com>
> Date:   Fri Oct 13 19:07:51 2023 +0200
>
>     i40e: Add initial devlink support
>
> I am not able to boot normally.  The console shows the message
>
> Failed to start Raise network interfaces
>
> Searching for this message on th internet produces some old discussions
> that suggest to look at the file /etc/network/interfaces.  That file on my
> system contains:
>
> # This file describes the network interfaces available on your system
> # and how to activate them. For more information, see interfaces(5).
>
> source /etc/network/interfaces.d/*
>
> # The loopback network interface
> auto lo
> iface lo inet loopback
>
> auto enp24s0f0
> iface enp24s0f0 inet dhcp
>
> -------------------------------
>
> The machine in question is part of a cluster, and may be set up in a
> specific way.  It actually does boot, in the sense that I get a
> login prompt, but it doesn't seem to be reachable from the outside.
>
> The above failure message is followed by a message about the inability to
> retrieve a file that is part of the local setup process.  I can find out
> more about what is supposed to be done with this file.
>
> Please let me know if there is any further information I can provide.

After some invetigation, it seems that the machine boots, but has no
access to the network.  And indeed, the information about the network for
this machine says:

eth0/enp24s0f0, Ethernet, configured rate: 10 Gbps, model: Intel Ethernet
Controller X710 for 10GbE SFP+, driver: i40e

All is fine on another machine in the same infrastructure that has a
different networking configuration:

eth0/eno1, Ethernet, configured rate: 25 Gbps, model: Mellanox
Technologies MT27710 Family [ConnectX-4 Lx], driver: mlx5_core, SR-IOV
enabled
eth1/eno2, Ethernet, configured rate: 25 Gbps, model: Mellanox
Technologies MT27710 Family [ConnectX-4 Lx], driver: mlx5_core, SR-IOV
enabled

thanks,
julia
