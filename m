Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4DF791CAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbjIDSRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbjIDSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:17:04 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35B12A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:16:58 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
        by cmsmtp with ESMTP
        id dBZhqS3rbEoVsdE8AqjvLv; Mon, 04 Sep 2023 18:16:58 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id dE89qCOYvWPjkdE89qsXAW; Mon, 04 Sep 2023 18:16:57 +0000
X-Authority-Analysis: v=2.4 cv=ea0uwpIH c=1 sm=1 tr=0 ts=64f61f19
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10
 a=bRdHEh57seZ_zvvW85sA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fp0gGJutDvvqPrc/IeMPV4i3FiQlzr/L5X+L2PJVi7w=; b=H6Q6IGMbDMnt49NLKY5YKcW6++
        1ab9OGOS1JbVE/fi8YpVaRUuw3eCsKZBQuEdRZjrTlakRvNL9dmkQUuZkFhHgsSdciwPkqy85xKUI
        prO5X2m9wutCplPjC3gW9D4hnn5ZK+n0+I9G4byNnuCkNBipgSc+SA7iOGKNM1qmY6ZOszQDXolcQ
        2HL0Pk0lfDTeu7MNYHsJywJSvHk49XA42toIAaCePkQryejmj4/nLlUKwhLSVHaUGoVX7abThZ0Vs
        9gsruAGt87y+SX/IkMvDM2ItzBQfrJtbwAxLHj75l9aWMhKzYR6gvTW0KUtCb0NuGBtFXIgWHcRpZ
        t2t1jt2A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:50842 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qdE88-001uk4-1P;
        Mon, 04 Sep 2023 13:16:56 -0500
Message-ID: <16805a62-8c8d-2a83-2ea0-da0f1a33a625@embeddedor.com>
Date:   Mon, 4 Sep 2023 12:17:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] wifi: mwifiex: Fix tlv_buf_left calculation
To:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <06668edd68e7a26bbfeebd1201ae077a2a7a8bce.1692931954.git.gustavoars@kernel.org>
 <169384778670.3420994.16227760665746324390.kvalo@kernel.org>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <169384778670.3420994.16227760665746324390.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qdE88-001uk4-1P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:50842
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGtOWI0qgpII2jIEGDaLn12aDQHGt4Q0yN9JLXOYxrFeucqyAuusOBX8PH4LX/ROseJLJH9ac8cEJByQ8xuuqIB+nh4xD9oNyN37BWYNG8Bq/e3qqf0m
 s5s+4jbV5BYoz11XsB5jgTYfAtxxwt3okLy0JpMBjhjodBFH0O0P+8jcZuQrQjvsVFAljxmswNCOZQh6AH0tHMPXCRrPNoNqRMYhGlkj4y8R1fQbx+/0PL5j
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 3 patches applied to wireless.git, thanks.

Awesome. :)

> 
> eec679e4ac5f wifi: mwifiex: Fix tlv_buf_left calculation
> c7847241de28 wifi: mwifiex: Replace one-element array with flexible-array member in struct mwifiex_ie_types_rxba_sync
> d5a93b7d2877 wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len
> 

Thanks!
--
Gustavo
