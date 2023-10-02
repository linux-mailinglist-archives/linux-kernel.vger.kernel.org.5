Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0157B5746
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbjJBP4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbjJBP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:56:44 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B032A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696262169; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bllaTzVNbyu3v5rSag5SGswSywadTc7l+pz7OIWiUIgbnoFAC7tmkOhfNavYkkf+hKSy/qOsMSp52sBbdfJq1y81miIdw6LsM1Xr3ADFksFrCsLKjV8uVxZoX9GdJ/tGZcxuFPTpG9hv/IdA1Rw936YiSFCkEVbrxo/EqES/z+E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1696262169; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=2GsfzeECTPPTE4gpp5vVnHomCT5yBhjA+mpLuL9YQB0=; 
        b=XhOUETY6Y0q5vZAL4DymkpE4HJhof9eO/8hcV4F2lxwMye/7yHc1wO0QtwSpN2CGZmsIqiOwa8zlGiLIrb4DQ54ew02ZnFa+4Z6IpTDE0RWe5CT9hJgjSi3SnjKA1Cp/lD6E5YoeBl/lztwFEQOnscXf8S2W+J3DuOZx1krnZ+A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=marliere.net;
        spf=pass  smtp.mailfrom=ricardo@marliere.net;
        dmarc=pass header.from=<ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1696262169;
        s=zmail; d=marliere.net; i=ricardo@marliere.net;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=2GsfzeECTPPTE4gpp5vVnHomCT5yBhjA+mpLuL9YQB0=;
        b=pAHgML6ntB+okEhJCtDSELRJlzce1azIHNbF/34Qbyt9za/mNB6WNa2wB9c+o0Uh
        ybYhDUHvXiRthBQDB7gV4EnjYD14fZZsxRju5piZoQBxZQziGCpU5FqPMYotkYQj8Bq
        fT1elOkp/S5UdwXjplGMCwwHdF+btsCTl0Ybd+4k=
Received: from localhost (177.104.93.54 [177.104.93.54]) by mx.zohomail.com
        with SMTPS id 1696262167246993.2648287452104; Mon, 2 Oct 2023 08:56:07 -0700 (PDT)
Date:   Mon, 2 Oct 2023 12:56:03 -0300
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     shaggy@kernel.org, wonguk.lee1023@gmail.com, liushixin2@huawei.com,
        andrew.kanner@gmail.com, wuhoipok@gmail.com,
        jfs-discussion@lists.sourceforge.net,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fs/jfs: Add check for negative db_l2nbperpage
Message-ID: <c52zvpisqgy6nvtw3fku342z5aqmz5gucfagaup2tflw5ia5d7@vbeanlsfhgqp>
References: <VI1P193MB0752E63048A98BC70E4CFA9E99C5A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1P193MB0752E63048A98BC70E4CFA9E99C5A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/02 05:56PM, Juntong Deng wrote:
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  fs/jfs/jfs_dmap.c | 3 ++-

Hey there, looks like you forgot to add a changelog for v1->v2? I see
you just changed the commit tags ordering but you should have that in
mind for next time :)

-	Ricardo
