Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0133F80CB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343678AbjLKNvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjLKNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:51:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A23C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:51:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FF9C433C7;
        Mon, 11 Dec 2023 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302708;
        bh=nIyuqcp4+4582x1GA9+XcGxtdjfRCxJK9Ur7alA/OAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZTaiK5Hs1zkFuyL8Ccm4MUAI7dzy6fHvQtOQP5QeL4ZU8FE5u/fDIYOIYjBN3ksM
         VXLRHOlJrkSfItbJ0VGSaF6IZWFQ6e5ZAuJI2A8y665EGsp2SZi4bXQQjn1AhPRjT0
         YrIoaxY7qCKLgO3d8G70VDMWfyVfQHUe1WI9J1EndI/O/RKfyUNwgVdAvj+QGgfSY1
         qCMyOvDEoKi/uulMaVKNU5cAG8rytCsqDdDjic5hU7bp75KYKVlPIuzQiBdK+A9YuP
         Rhja9p0ckqfW5W70JKXViaS8WmchCK1QSc5pFkqul0qwZ+PFlE64nrz3SNx5l7Qsan
         67WMgQtyjvfZw==
Date:   Mon, 11 Dec 2023 13:51:42 +0000
From:   Simon Horman <horms@kernel.org>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v4] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <20231211135142.GO5817@kernel.org>
References: <10981267.HhOBSzzNiN@silver>
 <20231206200913.16135-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206200913.16135-1-pchelkin@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 11:09:13PM +0300, Fedor Pchelkin wrote:
> If some of p9pdu_readf() calls inside case 'T' in p9pdu_vreadf() fails,
> the error path is not handled properly. *wnames or members of *wnames
> array may be left uninitialized and invalidly freed.
> 
> Initialize *wnames to NULL in beginning of case 'T'. Initialize the first
> *wnames array element to NULL and nullify the failing *wnames element so
> that the error path freeing loop stops on the first NULL element and
> doesn't proceed further.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Reviewed-by: Simon Horman <horms@kernel.org>

