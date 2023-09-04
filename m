Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5AF790F5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 02:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbjIDAfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 20:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjIDAfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 20:35:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED20D3;
        Sun,  3 Sep 2023 17:35:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 74784CE0B16;
        Mon,  4 Sep 2023 00:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E755C433C9;
        Mon,  4 Sep 2023 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693787722;
        bh=/cIwbQMTHa0igq1vsxu9HcKVqol1E1FbJz1i7NYrN28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltgr0YlotgjzCa9NiUFmk2cieTstmOULPvts3cbtsuAY7hWkp7/CP88OyNHPoktTB
         rqcXXGXLdhDahucuhmJNTJsQJ9+ajijNYbxFb1axAfSDMLkHZOSH/c71BDNUuKGfLZ
         VoHDk8CBbD7BQijhd05ie07AeiIBMA0WqhVnqQMdOyeN+Gdft4oVPXg7Oj79Fm9DH6
         ExEN5e2s6kFucn0sjaehvaKoXVEwIbb1vm8BI/fJKuFQTfhJveP1MNDUm3CpejYxRC
         BMskvOd4gd4s8WFHxjGxYtTl2PbJr3DnDBzCp+zDiv5EHIYjykMtS1lslWEIqwIWIx
         50kvXCPjY6THg==
Date:   Sun, 3 Sep 2023 20:35:21 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Shyam Prasad N <sprasad@microsoft.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Steve French <stfrench@microsoft.com>, pc@cjr.nz,
        lsahlber@redhat.com, pc@manguebit.com, vl@samba.org,
        ematsumiya@suse.de
Subject: Re: [PATCH AUTOSEL 5.10 5/7] cifs: add a warning when the in-flight
 count goes negative
Message-ID: <ZPUmSbkrb4sYcrpq@sashalap>
References: <20230829133336.520573-1-sashal@kernel.org>
 <20230829133336.520573-5-sashal@kernel.org>
 <2023082936-reborn-overjoyed-b3bc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2023082936-reborn-overjoyed-b3bc@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:47:28PM +0200, Greg KH wrote:
>On Tue, Aug 29, 2023 at 09:33:34AM -0400, Sasha Levin wrote:
>> From: Shyam Prasad N <sprasad@microsoft.com>
>>
>> [ Upstream commit e4645cc2f1e2d6f268bb8dcfac40997c52432aed ]
>>
>> We've seen the in-flight count go into negative with some
>> internal stress testing in Microsoft.
>>
>> Adding a WARN when this happens, in hope of understanding
>> why this happens when it happens.
>>
>> Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
>> Reviewed-by: Bharath SM <bharathsm@microsoft.com>
>> Signed-off-by: Steve French <stfrench@microsoft.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  fs/cifs/smb2ops.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>> index 015b7b37edee5..7ed6c2d4c549a 100644
>> --- a/fs/cifs/smb2ops.c
>> +++ b/fs/cifs/smb2ops.c
>> @@ -82,6 +82,7 @@ smb2_add_credits(struct TCP_Server_Info *server,
>>  		*val = 65000; /* Don't get near 64K credits, avoid srv bugs */
>>  		pr_warn_once("server overflowed SMB3 credits\n");
>>  	}
>> +	WARN_ON_ONCE(server->in_flight == 0);
>>  	server->in_flight--;
>>  	if (server->in_flight == 0 && (optype & CIFS_OP_MASK) != CIFS_NEG_OP)
>>  		rc = change_conf(server);
>> --
>> 2.40.1
>>
>
>Please drop this from all queues, it's debugging code for the CIFS
>developers, and they can debug it in Linus's tree, not in the stable
>trees where something like this is going to cause systems to reboot.

Dropped, thanks!

-- 
Thanks,
Sasha
