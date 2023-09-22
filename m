Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06217AA603
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 02:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjIVAW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 20:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIVAWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 20:22:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2FE110
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:22:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF1EC433C8;
        Fri, 22 Sep 2023 00:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695342164;
        bh=5Y1dSArHCMohqCCw0o+1oDIRhU1jcUN2P68mhAF6WFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FeJ3OJitd872v1C/2Uyd7XFKUmhWDaw0zhm25WIny4fOvHZpqhhmO5v43lXKFE5+x
         TIIrvH9ch66DY6PZDUcWLBovkJR7K7H0exdUOk9/44MV820WpWDBdvXQGu22PftktX
         3TSb5VzLlMZZZfRx+M39E3Hmvxe8+siE/7QSS5Tc=
Date:   Thu, 21 Sep 2023 17:22:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, ebiederm@xmission.com,
        kexec@lists.infradead.org, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
Message-Id: <20230921172243.d86a649d7afc835ff2caac26@linux-foundation.org>
In-Reply-To: <20230921215938.2192-1-eric.devolder@oracle.com>
References: <20230921215938.2192-1-eric.devolder@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 17:59:38 -0400 Eric DeVolder <eric.devolder@oracle.com> wrote:

> Scaled up testing has revealed that the kexec_trylock()
> implementation leads to failures within the crash hotplug
> infrastructure due to the inability to acquire the lock,
> specifically the message:
> 
> ...
>
> Convert the atomic lock to a mutex.
> 

Do you think this problem is serious enough to warrant a backport into
-stable kernels?  
