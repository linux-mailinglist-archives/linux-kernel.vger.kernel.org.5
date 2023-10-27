Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654177D8D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345228AbjJ0Dmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJ0Dmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:42:47 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70296198;
        Thu, 26 Oct 2023 20:42:44 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 07C80C01E; Fri, 27 Oct 2023 05:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698378163; bh=y/stKboTHsqJvzjY1OwTwMJdw+f8rbvk9J6LcpLr6UU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUPs8CfxjRy09gs9qkYmju40mDPmRi/8yto+SiQgkWhws33HqZHRnnP6UjuwMWiuv
         Dx+08ivcRiDjWFQd/jZOkvrUwm8Zf6KE1XJbPWFcZKXTW8SxtE8ECsmXespH0q1iY9
         XG4FMDiolos5EQNlDwKpU3NCFkZrxwdLKMmfVFNXMGQhk99BOCEF+kVaMIq782WSAW
         YcPliQaNFF0CnOlJkR7ytxGlu+5NXWKAlNddYCRIGcRyo2jqSJT4p/lou9C5ufCBwR
         1XfoAvQxFF3+o9Tr7hkZecTwZ4cmh6pEvkXxTf3fBp4RbSAfFLSUChu3yQO9dmK/0W
         JDmISjL96uQNw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 0FF59C01C;
        Fri, 27 Oct 2023 05:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698378153; bh=y/stKboTHsqJvzjY1OwTwMJdw+f8rbvk9J6LcpLr6UU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vWOyKBsbrYQrkIY/uefLXDTy9INAUqZ80ozwYs2+VHqm+z83mgSc1sUXTRElVGL+A
         gxpPCD70lUe4oSl8OV/M9nl7N3QF5ZJ6PhKBv3t8h3Tx5ZmTNRmGtVhO+5NJtQXgQ4
         0bKf4Rvh5f6MVkbtNK1lfJnu1CImdNnQyj7c18htDjUCCxbRD0JvgPouD+OgfJVeEo
         wzkgyFz4LqqeMKRz9h2p4PgobvydqO7IsNeBX7K9PJEaa0jOIUeIOhQNQr/CH3u8TH
         3IBinzTzzIUe1jr5Qva9YTtJGsHJqRW9CuIrVhVcju75474whsgzHl01zttE2Vgk8r
         Yq5OVgKWErc8Q==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 5ab81bb3;
        Fri, 27 Oct 2023 03:42:26 +0000 (UTC)
Date:   Fri, 27 Oct 2023 12:42:11 +0900
From:   asmadeus@codewreck.org
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, v9fs@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: 9p: fix possible memory leak in p9_check_errors()
Message-ID: <ZTsxkzODZ9yve0XL@codewreck.org>
References: <20231027030302.11927-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027030302.11927-1-hbh25y@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hangyu Hua wrote on Fri, Oct 27, 2023 at 11:03:02AM +0800:
> When p9pdu_readf() is called with "s?d" attribute, it allocates a pointer
> that will store a string. But when p9pdu_readf() fails while handling "d"
> then this pointer will not be freed in p9_check_errors().
> 
> Fixes: 51a87c552dfd ("9p: rework client code to use new protocol support functions")
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Thanks, pushed for next
-- 
Dominique Martinet | Asmadeus
