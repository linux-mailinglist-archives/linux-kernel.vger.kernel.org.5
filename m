Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23FD7F0158
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjKRRiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRRiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:38:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC03C0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 09:38:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C23C433C7;
        Sat, 18 Nov 2023 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700329131;
        bh=losrmXlk+odVwrmRe07GJMSdH6r8vdY76JOEkrAnT8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dByqGueYLz6b8vlOUGniQt46dHd66x1kFnRLjJoHw1Hsw7ap5Hv0cLdxFq2R12Pt9
         0v7hy1j2j7i5h3ntlKizusHrv8ilYQyGMH547b5A7PBANk1xTOtFDL+SFPjAWHkkpi
         hzW/90cbNGqQMOO8zfnR1jjFhklycNUr3v0E/WD+majI3yk4fwhdTk3Ak6fZl3yv/R
         fUz03ZUmfzLnot7uFZmXs1e+4JeMfjzJ059NIBzIGi1rUYm28QWJBmDPdu3DucQxnz
         qXGmyxbYnDamT/VZzFGsyCupkhj6eL/Oncyv+CVaUvB1ga36HmLi8frpE19ZsTdErw
         dYjKI4+y3XU+w==
Date:   Sat, 18 Nov 2023 09:38:49 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Message-ID: <20231118093849.14e36043@kernel.org>
In-Reply-To: <20231115081406.1bd9a4ed@hermes.local>
References: <1699484212-24079-1-git-send-email-longli@linuxonhyperv.com>
        <20231108181318.5360af18@kernel.org>
        <PH7PR21MB3263EBCF9600EEBD6D962B6ECEAEA@PH7PR21MB3263.namprd21.prod.outlook.com>
        <20231110120513.45ed505c@kernel.org>
        <20231115081406.1bd9a4ed@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 08:14:06 -0800 Stephen Hemminger wrote:
> Jakub is right that in an ideal world, this could all be managed by
> userspace. But the management of network devices in Linux is a
> dumpster fire! Every distro invents there own solution, last time
> I counted there were six different tools claiming to be the
> "one network device manager to rule them all". And that doesn't
> include all the custom scripts and vendor appliances.

To be clear, I thought Long Li was saying that the goal is work around
cases where VF is probed before netvsc. That seems like something that
can be prevented by the hypervisor.
