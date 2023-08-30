Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C811678DD76
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbjH3Sug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343636AbjH3Q2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:28:02 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A5B9;
        Wed, 30 Aug 2023 09:27:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 437C0900F0A;
        Wed, 30 Aug 2023 16:27:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BD2BC9004E1;
        Wed, 30 Aug 2023 16:27:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1693412877; a=rsa-sha256;
        cv=none;
        b=H4dTlF1ZhpSWKLwLBeyZimfRa351+sBRCe8MQuSmMwaokJR/hJ2G3qHTy/gZEgECIZDjot
        gQSTY71NtoRmCev5fatR/B/ciXFXoEYXOLHp19V6Kvefn4/73N9BKBGoOIylITOYuWYjsc
        gf3L6YDJKMyPD/gFumkY32S2wHEFgWY8nSZTSCdhMjyAy5TdfGiazzP5Hqyk+eNrgmZct5
        /QB2lqOGDi5V4sqvsV3y9m85ZMwBgtMwOsTmdivQMtE3GVElX3aEmvlsreFVFFn+r+Cyxj
        lLtcXCNPl6hiJciKdJCmyYNsOuwVUYNIO/vLKI2KHll1x8c+3pp50Ct/G7PRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1693412877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=aRWRZ6nCWmC/bKztsak+ItGZcWnENbj+WAmkTqUrQWk=;
        b=krRAL5y3yDkoB92zx7zibnfLi1ad/WrBpe+OIpAey+KexZewhQ1mpoWhT7cFJGB1t1y2ES
        TdcOJNZd4tW9NQhF8oowsku2c8ROt5uw7xDccMAFS4drhw7gvUrnNcTvtaAA9P8Qm0RIO9
        c7jTNQRQVMSDIfamFLL/PminKlNJiNKzVgkHq37Kyjs1BGdnj5XjzWX/D12pH9dxaiAKlo
        caSxtHayDvbavQaL5X4w8K8CBiaH+y62B0Ls5eZrtCpxZaY46A27u2YNOcZiqvpH3UmTn5
        bTLRwCtC5h3TLqAtulgSsr4NpsJsbQI8ho7HdK7hEOQxkoWjqQlnLA1V7xAk3g==
ARC-Authentication-Results: i=1;
        rspamd-6fd95854bb-m87fk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abortive-White: 033784c548e8b77a_1693412878064_951284777
X-MC-Loop-Signature: 1693412878064:1738632074
X-MC-Ingress-Time: 1693412878064
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.104.140 (trex/6.9.1);
        Wed, 30 Aug 2023 16:27:58 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4RbV8F0jdHz2f;
        Wed, 30 Aug 2023 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1693412877;
        bh=aRWRZ6nCWmC/bKztsak+ItGZcWnENbj+WAmkTqUrQWk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Y8vQDNU2V7B5Y6CgBnAqXi7lruMvKu90CJo7mM2tqOkDdvRLJiQ0Zfs4SCk0LnXcu
         BVFL0xZ2/JNi3CR37/nnkVjlAI6I1qi85tM6ulGz8OGM8hq1nv5cLDJ+tZIa4k8gjK
         y07QPP3tR3/6vSLWLvcouDDEiMZHGxpp2emZTjqKC4Pazo9ShfwdJqkdlMZFKZ5987
         ZCYm9BA+ZdhplFSiFlHiVR/89973O1mHe55mEACnHb49S3yoTthz7Nqd4k7XW6bRQ2
         Jzf02HyQ5DMMtfao5B/jvh3PZqsPgkUIXqsy7gnkkjndYp5z686tK+rPDgN25wlgA6
         fnANXHWU07G1Q==
Date:   Wed, 30 Aug 2023 08:48:37 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH] cxl/region: Clarify pointers in unregister_region()
Message-ID: <uksugjuktrlak5uvbndrtho7gwhvnxe2xftwxlqg4o4bemuar2@3gyuczh6n7dq>
References: <20230829-cxl-clarify-ptrs-v1-1-40e0705c6188@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230829-cxl-clarify-ptrs-v1-1-40e0705c6188@intel.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023, Ira Weiny wrote:

>devm_add_action_or_reset() passes a void * data parameter to the
>callback.  In the case of CXL regions, unregister_region() is passed a
>struct cxl_region *.
>
>unregister_region() incorrectly interprets this as a struct device
>pointer.  Fortunately the device structure was the first member of
>cxl_region.  Therefore the code still works.  However, should struct
>cxl_region change the bug could be subtle.
>
>Use the proper types in unregister_region() and extract the device
>pointer correctly.
>
>Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
>Cc: Ben Widawsky <bwidawsk@kernel.org>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
