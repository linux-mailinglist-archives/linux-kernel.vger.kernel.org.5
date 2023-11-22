Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BBE7F3C29
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343551AbjKVDG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjKVDGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:06:52 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BA44B10F1;
        Tue, 21 Nov 2023 19:06:42 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id B38D060621C85;
        Wed, 22 Nov 2023 11:06:31 +0800 (CST)
Message-ID: <22c4788d-1ba4-52c7-4ddc-5a3b0ec2acb3@nfschina.com>
Date:   Wed, 22 Nov 2023 11:06:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] misc: mei: client.c: fix some error code problem in
 mei_cl_write
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     tomas.winkler@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        alexander.usyskin@intel.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/20 23:03, Dan Carpenter wrote:
> On Mon, Nov 20, 2023 at 04:53:45PM +0800, Su Hui wrote:
>> Clang static analyzer complains that value stored to 'rets' is never
>> read. Remove some useless code, and let 'buf_len = -EOVERFLOW' to make
>> sure we can return '-EOVERFLOW'.
>>
>> mei_msg_hdr_init() return negative error code, rets should be
>> 'PTR_ERR(mei_hdr)' rather than '-PTR_ERR(mei_hdr)'.
>>
>> Fixes: 0cd7c01a60f8 ("mei: add support for mei extended header.")
>> Fixes: 8c8d964ce90f ("mei: move hbuf_depth from the mei device to the hw modules")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/misc/mei/client.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
>> index 9c8fc87938a7..00dac0a47da0 100644
>> --- a/drivers/misc/mei/client.c
>> +++ b/drivers/misc/mei/client.c
>> @@ -2011,7 +2011,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long time
>>   
>>   	mei_hdr = mei_msg_hdr_init(cb);
>>   	if (IS_ERR(mei_hdr)) {
>> -		rets = -PTR_ERR(mei_hdr);
>> +		rets = PTR_ERR(mei_hdr);
> KTODO: write a static checker rule which complains -PTR_ERR()
>
> This might be complicated because there are parts of networking where
> we store error codes as positive values.  But there is enough context in
> this function to create some sort of warning about this code.  "Mixing
> positive and negative error codes" perhaps?

Maybe add a check in checkpatch.pl is a good idea?

>
> $ git grep -n '\-PTR_ERR'
> block/partitions/core.c:574:                   disk->disk_name, p, -PTR_ERR(part));
> drivers/infiniband/ulp/ipoib/ipoib_multicast.c:291:                        -PTR_ERR(ah));
> drivers/misc/mei/client.c:2014:         rets = -PTR_ERR(mei_hdr);
> drivers/net/ethernet/intel/igb/igb_main.c:8963:                 unsigned int xdp_res = -PTR_ERR(skb);
> drivers/net/ethernet/intel/igc/igc_main.c:2639:                 unsigned int xdp_res = -PTR_ERR(skb);
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2348:                     unsigned int xdp_res = -PTR_ERR(skb);
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:5431:                         unsigned int xdp_res = -PTR_ERR(skb);
> drivers/phy/sunplus/phy-sunplus-usb2.c:278:             ret = -PTR_ERR(phy);
> drivers/scsi/libfc/fc_elsct.c:86:               switch (-PTR_ERR(fp)) {
> drivers/scsi/libfc/fc_lport.c:1081:                  IS_ERR(fp) ? -PTR_ERR(fp) : 0, fc_lport_state(lport),
> fs/ext4/indirect.c:1042:                                ext4_error_inode_block(inode, nr, -PTR_ERR(bh),
> fs/jffs2/background.c:48:                       -PTR_ERR(tsk));
> fs/ntfs/dir.c:92:                               -PTR_ERR(m));
> fs/ntfs/dir.c:312:                              -PTR_ERR(page));
> fs/ntfs/dir.c:643:                              -PTR_ERR(m));
> fs/ntfs/dir.c:790:                              -PTR_ERR(page));
> fs/ntfs/index.c:141:                            -PTR_ERR(m));
> fs/ntfs/index.c:268:                            -PTR_ERR(page));
> fs/ntfs/mft.c:162:      ntfs_error(ni->vol->sb, "Failed with error code %lu.", -PTR_ERR(m));
> fs/ntfs/mft.c:289:                              "mft record, error code %ld.", -PTR_ERR(m));
> net/ipv6/af_inet6.c:852:                        WRITE_ONCE(sk->sk_err_soft, -PTR_ERR(dst));
> net/ipv6/inet6_connection_sock.c:123:           WRITE_ONCE(sk->sk_err_soft, -PTR_ERR(dst));
> tools/lib/bpf/libbpf.c:10044:           errno = -PTR_ERR(ptr);
> tools/lib/bpf/libbpf_internal.h:520:            errno = -PTR_ERR(ret);
> tools/testing/selftests/bpf/prog_tests/btf_dump.c:59:           err = -PTR_ERR(btf);
> tools/testing/selftests/bpf/prog_tests/sk_lookup.c:483:         errno = -PTR_ERR(link);
>
> Quite a few of those were in printks and it might be an opportunity to
> use %pe to print the ENOMEM etc strings instead of the number.

I will try sending some patch for this.

Thanks for your suggestions.

Su Hui

