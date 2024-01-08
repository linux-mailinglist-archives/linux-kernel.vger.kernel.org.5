Return-Path: <linux-kernel+bounces-20088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CBF827924
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EC51C23092
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C328255C09;
	Mon,  8 Jan 2024 20:26:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451CE5577B;
	Mon,  8 Jan 2024 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4T85FP1rFXz9smW;
	Mon,  8 Jan 2024 21:26:49 +0100 (CET)
Message-ID: <d7e6ff1d-f69f-4e48-8167-7dbcb0d8093f@v0yd.nl>
Date: Mon, 8 Jan 2024 21:26:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] Bluetooth: Remove pending ACL connection attempts
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, verdre@v0yd.nl
References: <20240108183938.468426-1-verdre@v0yd.nl>
 <20240108183938.468426-5-verdre@v0yd.nl>
 <5d1f2013-5758-4d6c-8d01-e96a76bb2686@v0yd.nl>
 <40550fc1-3b5b-438c-891d-2da0f30874f3@v0yd.nl>
 <CABBYNZKV8SujJ7GFUqTMXUskE=yK0q=opmwvTZNEpPb=JkiQbA@mail.gmail.com>
 <d1e7219f-e7b4-4474-ae89-70925b8787fa@v0yd.nl>
 <CABBYNZLNeKOT0n=D-PN=aPgfu07xZ-x8nNKitas40X=0Snp4jQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <CABBYNZLNeKOT0n=D-PN=aPgfu07xZ-x8nNKitas40X=0Snp4jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 1/8/24 20:41, Luiz Augusto von Dentz wrote:
> Hi Jonas,
> 
> On Mon, Jan 8, 2024 at 2:29 PM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>
>> Hi Luiz,
>>
>> On 1/8/24 20:14, Luiz Augusto von Dentz wrote:
>>> Hi Jonas,
>>>
>>> On Mon, Jan 8, 2024 at 1:55 PM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>>>
>>>> On 1/8/24 19:44, Jonas Dreßler wrote:
>>>>> On 1/8/24 19:39, Jonas Dreßler wrote:
>>>>>> With the last commit we moved to using the hci_sync queue for "Create
>>>>>> Connection" requests, removing the need for retrying the paging after
>>>>>> finished/failed "Create Connection" requests and after the end of
>>>>>> inquiries.
>>>>>>
>>>>>> hci_conn_check_pending() was used to trigger this retry, we can remove it
>>>>>> now.
>>>>>>
>>>>>> Note that we can also remove the special handling for COMMAND_DISALLOWED
>>>>>> errors in the completion handler of "Create Connection", because "Create
>>>>>> Connection" requests are now always serialized.
>>>>>>
>>>>>> This is somewhat reverting commit 4c67bc74f016 ("[Bluetooth] Support
>>>>>> concurrent connect requests").
>>>>>>
>>>>>> With this, the BT_CONNECT2 state of ACL hci_conn objects should now be
>>>>>> back to meaning only one thing: That we received a connection request
>>>>>> from another device (see hci_conn_request_evt), but the actual connect
>>>>>> should be deferred.
>>>>>> ---
>>>>>>     include/net/bluetooth/hci_core.h |  1 -
>>>>>>     net/bluetooth/hci_conn.c         | 16 ----------------
>>>>>>     net/bluetooth/hci_event.c        | 21 ++++-----------------
>>>>>>     3 files changed, 4 insertions(+), 34 deletions(-)
>>>>>>
>>>>>> diff --git a/include/net/bluetooth/hci_core.h
>>>>>> b/include/net/bluetooth/hci_core.h
>>>>>> index 2c30834c1..d7483958d 100644
>>>>>> --- a/include/net/bluetooth/hci_core.h
>>>>>> +++ b/include/net/bluetooth/hci_core.h
>>>>>> @@ -1330,7 +1330,6 @@ struct hci_conn *hci_conn_add(struct hci_dev
>>>>>> *hdev, int type, bdaddr_t *dst,
>>>>>>                       u8 role);
>>>>>>     void hci_conn_del(struct hci_conn *conn);
>>>>>>     void hci_conn_hash_flush(struct hci_dev *hdev);
>>>>>> -void hci_conn_check_pending(struct hci_dev *hdev);
>>>>>>     struct hci_chan *hci_chan_create(struct hci_conn *conn);
>>>>>>     void hci_chan_del(struct hci_chan *chan);
>>>>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>>>>> index 541d55301..22033057b 100644
>>>>>> --- a/net/bluetooth/hci_conn.c
>>>>>> +++ b/net/bluetooth/hci_conn.c
>>>>>> @@ -2534,22 +2534,6 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
>>>>>>         }
>>>>>>     }
>>>>>> -/* Check pending connect attempts */
>>>>>> -void hci_conn_check_pending(struct hci_dev *hdev)
>>>>>> -{
>>>>>> -    struct hci_conn *conn;
>>>>>> -
>>>>>> -    BT_DBG("hdev %s", hdev->name);
>>>>>> -
>>>>>> -    hci_dev_lock(hdev);
>>>>>> -
>>>>>> -    conn = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
>>>>>> -    if (conn)
>>>>>> -        hci_cmd_sync_queue(hdev, hci_acl_create_connection_sync,
>>>>>> conn, NULL);
>>>>>> -
>>>>>> -    hci_dev_unlock(hdev);
>>>>>> -}
>>>>>> -
>>>>>>     static u32 get_link_mode(struct hci_conn *conn)
>>>>>>     {
>>>>>>         u32 link_mode = 0;
>>>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>>>>> index e8b4a0126..91973d6d1 100644
>>>>>> --- a/net/bluetooth/hci_event.c
>>>>>> +++ b/net/bluetooth/hci_event.c
>>>>>> @@ -117,8 +117,6 @@ static u8 hci_cc_inquiry_cancel(struct hci_dev
>>>>>> *hdev, void *data,
>>>>>>             hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>>>>>>         hci_dev_unlock(hdev);
>>>>>> -    hci_conn_check_pending(hdev);
>>>>>> -
>>>>>>         return rp->status;
>>>>>>     }
>>>>>> @@ -149,8 +147,6 @@ static u8 hci_cc_exit_periodic_inq(struct hci_dev
>>>>>> *hdev, void *data,
>>>>>>         hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);
>>>>>> -    hci_conn_check_pending(hdev);
>>>>>> -
>>>>>>         return rp->status;
>>>>>>     }
>>>>>> @@ -2296,10 +2292,8 @@ static void hci_cs_inquiry(struct hci_dev
>>>>>> *hdev, __u8 status)
>>>>>>     {
>>>>>>         bt_dev_dbg(hdev, "status 0x%2.2x", status);
>>>>>> -    if (status) {
>>>>>> -        hci_conn_check_pending(hdev);
>>>>>> +    if (status)
>>>>>>             return;
>>>>>> -    }
>>>>>>         set_bit(HCI_INQUIRY, &hdev->flags);
>>>>>>     }
>>>>>> @@ -2323,12 +2317,9 @@ static void hci_cs_create_conn(struct hci_dev
>>>>>> *hdev, __u8 status)
>>>>>>         if (status) {
>>>>>>             if (conn && conn->state == BT_CONNECT) {
>>>>>> -            if (status != HCI_ERROR_COMMAND_DISALLOWED ||
>>>>>> conn->attempt > 2) {
>>>>>> -                conn->state = BT_CLOSED;
>>>>>> -                hci_connect_cfm(conn, status);
>>>>>> -                hci_conn_del(conn);
>>>>>> -            } else
>>>>>> -                conn->state = BT_CONNECT2;
>>>>>> +            conn->state = BT_CLOSED;
>>>>>> +            hci_connect_cfm(conn, status);
>>>>>> +            hci_conn_del(conn);
>>>>>>             }
>>>>>>         } else {
>>>>>>             if (!conn) {
>>>>>> @@ -3020,8 +3011,6 @@ static void hci_inquiry_complete_evt(struct
>>>>>> hci_dev *hdev, void *data,
>>>>>>         bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
>>>>>> -    hci_conn_check_pending(hdev);
>>>>>> -
>>>>>>         if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
>>>>>>             return;
>>>>>> @@ -3247,8 +3236,6 @@ static void hci_conn_complete_evt(struct hci_dev
>>>>>> *hdev, void *data,
>>>>>>     unlock:
>>>>>>         hci_dev_unlock(hdev);
>>>>>> -
>>>>>> -    hci_conn_check_pending(hdev);
>>>>>>     }
>>>>>>     static void hci_reject_conn(struct hci_dev *hdev, bdaddr_t *bdaddr)
>>>>>
>>>>> Please take a special look at this one: I'm not sure if I'm breaking the
>>>>> functionality of deferred connecting using BT_CONNECT2 in
>>>>> hci_conn_request_evt() here, as I don't see anywhere where we check for
>>>>> this state and establish a connection later.
>>>>>
>>>>> It seems that this is how hci_conn_request_evt() was initially written
>>>>> though, hci_conn_check_pending() only got introduced later and seems
>>>>> unrelated.
>>>>
>>>> Ahh nevermind... The check for BT_CONNECT2 on "Conn Complete event" got
>>>> introduced with 4c67bc74f01 ([Bluetooth] Support concurrent connect
>>>> requests). And later the deferred connection setup on "Conn Request
>>>> event" got introduced with 20714bfef8 ("Bluetooth: Implement deferred
>>>> sco socket setup").
>>>>
>>>> I assume the latter commit was relying on the "Create Connection"
>>>> request "Conn Complete event" that got introduced with the former commit
>>>> then? That would imply that we use BT_CONNECT2 if there's already a
>>>> "Create Connection" going on when the "Conn Request event" happens, and
>>>> we must wait for that existing request to finish.. Is that how those
>>>> deferred connections are supposed to work?
>>>
>>> Well if you are not sure that works we better make sure we have tests
>>> that cover this, for LE I know for sure it works because we have the
>>> likes of iso-tester that do connect 2 peers simultaneously, but for
>>> classic I don't recall having any test that does multiple connections.
>>
>> The sequential "Create Connection" logic works, I tested that (of course
>> I'm happy to add tests if it's not too much work).
>>
>> What I'm unsure about is if and how incoming connection requests from
>> other devices with HCI_PROTO_DEFER flag are supposed to work and whether
>> they are meant to trigger a "Create Connection" from us?
> 
> For incoming connections on Classic that should result in an
> accept/reject connection command, so it should cause another Create
> Connection if that is what you are afraid of.
> 

Hmm, do you mean it *shouldn't* cause another "Create Connection"?

I just checked in the spec: It sounds like once we send the "Accept 
Connection Request" to the controller, the controller takes care of 
establishing the connection by itself (no "Create Connection" 
necessary), and will then later give us a "Connection Complete" event to 
indicate that the connection is done.

If I'm reading all this correctly, that sounds like my commit is 
correct, and we had a bug in this logic before by interpreting 
BT_CONNECT2 in two different ways.

>>>
>>>>>
>>>>> Thanks,
>>>>> Jonas
>>>
>>>
>>>
> 
> 
> 

